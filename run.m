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

% Last Modified by GUIDE v2.5 09-Nov-2013 12:15:20

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
global winvid
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);
% winvid = videoinput('winvideo',1,'YUY2_640x480');
% preview(winvid);
[I,IG,HSV,IE]= getData(handles,hObject);
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
disp('-======= Corriendo deteccion de placa vehicular =======-')
tic
global p
[I,IG,HSV,IE]= getData(handles,hObject);
placa = imread('train/placa.jpg');
[i]=ventanaD(IG,175,350,100,100,placa);

axes(handles.axes1);imshow(I)
axes(handles.axes2);imshow(IG)
axes(handles.axes3);
p= IG(i(1):i(2),i(3):i(4),:); % Mascara cortada 
[p re]=lines(p); % Cortamos la imagen 
p =imresize(p ,[100 200]); % Resizing the image keeping aspect ratio same.
imshow(p)

axes(handles.axes4)

p= ait_imgneg(p); % Aplicamos negativo a la imagen
se=strel('square',4);
p=imerode(p,se);   % Erosionamos la imagen
se=strel('square',3);
p=imdilate(p,se); % Dilatamos la imagen
p= bwareaopen(p,200); % Eliminamos los elementos pequeños con intensidad alta(255)

imshow(p)
p = imclearborder(p); % Eliminamos el borde de la imagen con intensidad alta(255)

se=strel('square',2);
% p=imerode(p,se); % Erosionamos imagen
% p=imdilate(p,se); % Dilatamos la imagen
% p= bwareaopen(p,170); % Eliminamos elemantos medianos
[p re]=lines(p); % Cortamos la imagen
% p=imdilate(p,se); % Dilatamos la imagen
placa = [];
imshow(p)

global templates
load templates

[L Ne] = bwlabel(p);
for n=1:Ne
    [r,c] = find(L==n);
    n1=p(min(r):max(r),min(c):max(c));
    img_r=imresize(n1,[100 42]);
%     imshow(img_r);
%     pause(1)
    if n <= 3
        caracter=clasificador_letras(img_r,26);
    else
        caracter=clasificador_numbers(img_r,36);
    end
    placa=[placa caracter];
end

set(handles.text1,'String',placa)

button_state = get(handles.radiobutton1, 'Value');
if button_state
    URL = 'http://guybrush.info/web_files/';
    str = urlread(URL,'Get',{'placa',placa});
    set(handles.text2,'String','web "http://guybrush.info/web_files/"')
else
    set(handles.text2,'String','')
end


toc
disp('-=======     Finalizado ...      =======-')



function [I,IG,HSV,IE]= getData(handles,hObject)
global winvid


button_state2 = get(handles.radiobutton2, 'Value');

if button_state2
    I= getsnapshot(winvid);
    I = YUY2toRGB(I);
    % imwrite(I,'imagen.jpg','jpeg');
else
    I = imread(get(handles.edit1,'String'));
end

I =imresize(I ,[1500 NaN]); % Resizing the image keeping aspect ratio same.
for i=1:3
    %     I(:,:,i) = ecualizacion_histograma(I(:,:,i),8);
end
HSV =[  0.1041    0.7794    0.5573
        0.1394    1.0000    0.9811
        0.1277    0.9787    0.8074
        0.1461    1.0000    1.0000
        0.1237    0.9550    0.6602
        0.1138    0.9386    0.5825
        0.1321    1.0000    0.7715];
IE = colorDetectHSV(I, median(HSV), [0.25 0.7 0.7]);
size(IE)

IG=rgb2gray(I);

B= edge(IG,'sobel'); % Aplicamos SOBEL para ver los bordes de la imagen
se=strel('square',9);
IG2=imdilate(B,se); % Dilatamos la imagen
IG2= imfill(IG2,'holes'); % Rellenamos todos los huecos para asi tener la parte de la placa

ID= ait_imgneg(B);
IG=uint8(IG).*uint8(IG2).*uint8(IE);
IG=realce(IG,120,255);

% IG= imfill(IG,'holes');




function newdata = YUY2toRGB(data)
Y = single(data(:,:,1));
U = single(data(:,:,2));
V = single(data(:,:,3));
C = Y-16;
D = U - 128;
E = V - 128;
R = uint8((298*C+409*E+128)/256);
G = uint8((298*C-100*D-208*E+128)/256);
B = uint8((298*C+516*D+128)/256);
newdata = uint8(zeros(size(data)));
newdata(:,:,1)=R;
newdata(:,:,2)=G;
newdata(:,:,3)=B;



% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
