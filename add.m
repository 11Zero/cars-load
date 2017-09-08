function varargout = add(varargin)
% ADD MATLAB code for add.fig
%      ADD, by itself, creates a new ADD or raises the existing
%      singleton*.
%
%      H = ADD returns the handle to a new ADD or the handle to
%      the existing singleton*.
%
%      ADD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ADD.M with the given input arguments.
%
%      ADD('Property','Value',...) creates a new ADD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before add_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to add_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help add

% Last Modified by GUIDE v2.5 23-Aug-2017 15:12:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @add_OpeningFcn, ...
                   'gui_OutputFcn',  @add_OutputFcn, ...
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


% --- Executes just before add is made visible.
function add_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to add (see VARARGIN)

% Choose default command line output for add
handles.output = hObject;
global filename;
global pathname;
filename = '';
pathname = '';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes add wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = add_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_add.
function button_add_Callback(hObject, eventdata, handles)
% hObject    handle to button_add (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global filename;
global pathname;
[a, b] = uigetfile( ...
{'*.xls;*.xlsx','Excel Files (*.xls,*.xlsx)';
   '*.xls',  'Excel 2003 (*.xls)'; ...
   '*.fig','Excel 2007 (*.xlsx)'}, ...
   '选择Excel文件');
if a~=0
    filename=a;
    pathname = b;
    set(handles.text_status,'String',sprintf('车流文件:%s',filename));
end

function edit_len_Callback(hObject, eventdata, handles)
% hObject    handle to edit_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_len as text
%        str2double(get(hObject,'String')) returns contents of edit_len as a double


% --- Executes during object creation, after setting all properties.
function edit_len_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_len (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_fun_Callback(hObject, eventdata, handles)
% hObject    handle to edit_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_fun as text
%        str2double(get(hObject,'String')) returns contents of edit_fun as a double


% --- Executes during object creation, after setting all properties.
function edit_fun_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_fun (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.text_status,'String','计算中，请等待...');
global filename;
global pathname;
len = str2double(get(handles.edit_len,'String'));
if len ==0
    set(handles.text_status,'String',sprintf('桥长无效'));
    return;
end
if strcmp(filename,'') || strcmp(pathname,'')
    set(handles.text_status,'String','未选择随机车流文件');
    return;
end

X=0:0.1:len;  %桥长为30m，以0.1m为一个单位
% yingxiangxian=-0.01.*X.^2+X;   %桥梁跨中弯矩M影响线方程
% p1=0;
% %p1=-0.00804755368742752;
% p2=0.0907112783108678;
% p3=-0.0171400876861163;
% p4=-2.84774382307739e-6;
str = '-0.00804755368742752+0.0907112783108678.*X+-0.0171400876861163.*X.^1.5+-2.84774382307739e-6.*X.^3';
fun_str = get(handles.edit_fun,'String');
eval(sprintf('yingxiangxian=%s;',fun_str));
% yingxiangxian=p1+p2.*X+p3.*X.^1.5+p4.*X.^3;   %桥梁跨中弯矩M影响线方程
% figure(1); plot(X,yingxiangxian,'r')
hezai=xlsread(sprintf('%s%s',[pathname filename]),'Sheet1'); %读入EXCEL表格的随机荷载，单位KN
hezai=hezai';
zhi=zeros(1,(length(hezai)+length(X)));
for i=1:length(zhi)
    if i<=length(X)
        zhi(i)=sum(hezai((length(hezai)-i+1):length(hezai)).*yingxiangxian(1:i));
    elseif (length(X)<i)&&(i<=length(hezai))
        m=length(hezai)-i+1;
        n=length(hezai)-i+length(X);
        zhi(i)=sum(hezai(m:n).*yingxiangxian);
    else
         m=hezai((i-length(X)):length(hezai));
         n=yingxiangxian((i-length(hezai)):length(X));
         zhi(i)=sum(m.*n);
    end
end
heng=1:(length(X)+length(hezai));
axes(handles.axes1);
plot(heng,zhi) 
xlabel('荷载效应长度');ylabel('荷载效应值KN*m');
Maxzhi=max(zhi)   %单位KN*m
axes(handles.axes2);
hist(zhi,80);
xlabel('荷载效应值');ylabel('频数');
axes(handles.axes3);
[ni,ak]=hist(zhi,80);
fi=ni/length(zhi);
bar(ak,fi);
xlabel('荷载效应值');ylabel('频率');
set(handles.text_status,'String','计算完成');
