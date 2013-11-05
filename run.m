function varargout = run(varargin)
% RUN MATLAB code for run.fig
%      RUN, by itself, creates a new RUN or raises the existing
%      singleton*.
%
%      H = RUN returns the handle to a new RUN or the handle to
%      the existing singleton*.
%
%      RUN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RUN.M with the given input arguments.
%
%      RUN('Property','Value',...) creates a new RUN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before run_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to run_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
%asdasddasdasd
% Edit the above text to modify the response to help run

% Last Modified by GUIDE v2.5 25-Sep-2013 19:56:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @run_OpeningFcn, ...
    'gui_OutputFcn',  @run_OutputFcn, ...
    'gui_LayoutFcn',  [] , ...
    'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before run is made visible.
function run_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to run (see VARARGIN)

% Choose default command line output for run
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
[I,IG,HSV,IE]= getData(handles);
axes(handles.axes1)
imshow(I)
axes(handles.axes2)
imshow(IG)


% UIWAIT makes run wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = run_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Reconocimiento de placa.
function pushbutton1_Callback(hObject, eventdata, handles)
disp('=== Corriendo deteccion de placa vehicular ===')
tic
global p
[I,IG,HSV,IE]= getData(handles);
placa = imread('train/placa.jpg');
[p]=ventanaD(IG,100,200,20,10,placa);

axes(handles.axes1);imshow(I) 
axes(handles.axes2);imshow(IG)
axes(handles.axes3);  
se=strel('square',1); 
p=imdilate(p,se);
imshow(p)


toc
disp('=== Finalizado ... ===')

% --- Reconocimiento de caracter.
function pushbutton2_Callback(hObject, eventdata, handles)
global p

axes(handles.axes4)
size(p)
p= ait_imgneg(p); % Aplicamos negativo a la imagen
se=strel('disk',1); 
p=imerode(p,se);   % Erosionamos la imagen
p= bwareaopen(p,20); % Eliminamos los elementos peque�os con intensidad alta(255)
p = imclearborder(p); % Eliminamos el borde de la imagen con intensidad alta(255)
p= bwareaopen(p,100); % Eliminamos elemantos medianos
se=strel('square',1); 
p=imerode(p,se); % Erosionamos la imagen
p= bwareaopen(p,100); % Eliminamos elemantos medianos
p=imdilate(p,se); % Dilatamos la imagen
[p re]=lines(p); % Cortamos la imagen
imshow(p)


% [y] = clasificador(p);
% [x,y]=ventanaD(IE,50,30,50,30)

function [I,IG,HSV,IE]= getData(handles)
I = imread(get(handles.edit1,'String'));
I =imresize(I ,[500 NaN]); % Resizing the image keeping aspect ratio same.
for i=1:3
    I(:,:,i) = ecualizacion_histograma(I(:,:,i),8);
end
HSV =[ 0.1269    0.9226    0.8045
    0.1522    0.7330    0.9741
    0.1336    0.9364    0.5206
    0.1333    0.9741    0.6984
    0.1592    0.6452    0.9472
    0.1635    0.7106    0.9727
    0.2040    0.1259    0.9806
    0.1677    0.8785    0.9440];
IE = colorDetectHSV(I, median(HSV), [0.16 0.8 0.5]);
size(IE)
 
IG=rgb2gray(I);

B= edge(IG,'sobel');
se=strel('square',3); 
IG2=imdilate(B,se); % Dilatamos la imagen
IG2= imfill(IG2,'holes');

ID= ait_imgneg(B);
IG=uint8(IG).*uint8(ID).*uint8(IE).*uint8(IG2);
 IG=realce(IG,175,255);
