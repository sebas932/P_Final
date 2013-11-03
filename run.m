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

% Last Modified by GUIDE v2.5 06-Nov-2013 23:29:25

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
winvid = videoinput('winvideo',1,'YUY2_640x480');
preview(winvid);
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
[i]=ventanaD(IG,100,200,20,10,placa);

axes(handles.axes1);imshow(I)
axes(handles.axes2);imshow(IG)
axes(handles.axes3);
p= IG(i(1):i(2),i(3):i(4),:);
imshow(p)

axes(handles.axes4)
size(p)
p= ait_imgneg(p); % Aplicamos negativo a la imagen
se=strel('square',2);
p=imerode(p,se);   % Erosionamos la imagen
p= bwareaopen(p,20); % Eliminamos los elementos pequeños con intensidad alta(255)
p = imclearborder(p); % Eliminamos el borde de la imagen con intensidad alta(255)
p= bwareaopen(p,100); % Eliminamos elemantos medianos
se=strel('square',1);
p=imerode(p,se); % Erosionamos la imagen
p= bwareaopen(p,100); % Eliminamos elemantos medianos
p=imdilate(p,se); % Dilatamos la imagen
[p re]=lines(p); % Cortamos la imagen
placa = [];
load templates
global templates
[L Ne] = bwlabel(p);
for n=1:Ne
    [r,c] = find(L==n);
    n1=p(min(r):max(r),min(c):max(c));
    img_r=imresize(n1,[100 42]);
    imshow(img_r);
    caracter=clasificador(img_r,36);
    placa=[placa caracter];
end
imshow(p)
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
else
    I = imread(get(handles.edit1,'String'));
end

 
I =imresize(I ,[500 NaN]); % Resizing the image keeping aspect ratio same.
for i=1:3
    I(:,:,i) = ecualizacion_histograma(I(:,:,i),8);
end
HSV =[   0.1563    0.9890    0.9481
    0.1570    0.9909    0.9345
    0.1409    0.9942    0.9439
    0.1263    0.3452    0.7327
    0.0918    0.3229    0.8530
    0.1326    0.7155    0.7471
    0.0806    0.4227    0.6282
    0.1330    0.6350    0.8055];
IE = colorDetectHSV(I, median(HSV), [0.35 0.6 0.6]);
size(IE)

IG=rgb2gray(I);

B= edge(IG,'sobel'); % Aplicamos SOBEL para ver los bordes de la imagen
se=strel('disk',4);
IG2=imdilate(B,se); % Dilatamos la imagen
IG2= imfill(IG2,'holes'); % Rellenamos todos los huecos para asi tener la parte de la placa

ID= ait_imgneg(B);
IG=uint8(IG).*uint8(IE).*uint8(IG2);
IG=realce(IG,170,255);

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
