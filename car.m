function varargout = car(varargin)
% CAR MATLAB code for car.fig
%      CAR, by itself, creates a new CAR or raises the existing
%      singleton*.
%
%      H = CAR returns the handle to a new CAR or the handle to
%      the existing singleton*.
%
%      CAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CAR.M with the given input arguments.
%
%      CAR('Property','Value',...) creates a new CAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before car_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to car_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help car

% Last Modified by GUIDE v2.5 16-Aug-2017 17:11:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @car_OpeningFcn, ...
                   'gui_OutputFcn',  @car_OutputFcn, ...
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


function callback_sel_list(hObject, eventdata, handles)
%%
%下拉控件的回调函数
tag = get(hObject,'Tag');
index = str2double(tag(10));
contents = cellstr(get(hObject,'String'));
value = contents{get(hObject,'Value')};
global sel_list;
global car_table_data;
if strcmp(value,sel_list{1})
    car_table_data(index,3) = 1;
elseif strcmp(value,sel_list{2})
    car_table_data(index,3) = 2;
elseif strcmp(value,sel_list{3})
    car_table_data(index,3) = 3;
end
update_table();


function update_table()
%%
global main_handle;
global car_table_data;
table_data = get(main_handle.table_car_per,'data');
table_size = size(car_table_data);
for i=1:table_size(1)
    for j=1:table_size(2)
        if (car_table_data(i,3)==1 || car_table_data(i,3)==2) && (j==8 || j==9 || j==10)
            table_data{i,j}='No need';
        else
             table_data{i,j} = num2str(car_table_data(i,j));
        end
    end
end
set(main_handle.table_car_per,'data',table_data);


% --- Executes on button press in button_ok.
function button_ok_Callback(hObject, eventdata, handles)
%%
% hObject    handle to button_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% global car_table_data;
global dis_info;
global sel_list;
contents = cellstr(get(handles.popupmenu_dis,'String'));
value = contents{get(handles.popupmenu_dis,'Value')};
if strcmp(value,sel_list{1})
    dis_info(1)=1;
elseif strcmp(value,sel_list{2})
    dis_info(1)=2;
end
dis_info(2) = str2double(get(handles.edit_dis_miu,'String'));
dis_info(3) = str2double(get(handles.edit_dis_sigma,'String'));
dis_info(4) = str2double(get(handles.edit_dis_max,'String'));
dis_info(5) = str2double(get(handles.edit_dis_min,'String'));
global car_table_data;
N = car_table_data(:,2)';
WeightType = car_table_data(:,3:10);
Distance = dis_info';
xlsdata4 = cell(15,8);
global main_handle;
temp_style = main_handle.load_style;

xlsdata4{2,3} = temp_style(1,2);
xlsdata4{3,3} = temp_style(1,1);
xlsdata4{3,4} = temp_style(1,3);

xlsdata4{4,3} = temp_style(2,2);
xlsdata4{5,3} = temp_style(2,1);
xlsdata4{5,4} = temp_style(2,3);

xlsdata4{6,3} = temp_style(3,2);
xlsdata4{7,3} = temp_style(3,1);
xlsdata4{7,4} = temp_style(3,3);

xlsdata4{8,3} = temp_style(4,2);
xlsdata4{8,4} = temp_style(4,4);
xlsdata4{9,3} = temp_style(4,1);
xlsdata4{9,4} = temp_style(4,3);
xlsdata4{9,5} = temp_style(4,5);

xlsdata4{10,3} = temp_style(5,2);
xlsdata4{10,4} = temp_style(5,4);
xlsdata4{10,5} = temp_style(5,6);
xlsdata4{11,3} = temp_style(5,1);
xlsdata4{11,4} = temp_style(5,3);
xlsdata4{11,5} = temp_style(5,5);
xlsdata4{11,6} = temp_style(5,7);

xlsdata4{12,3} = temp_style(6,2);
xlsdata4{12,4} = temp_style(6,4);
xlsdata4{12,5} = temp_style(6,6);
xlsdata4{12,6} = temp_style(6,8);
xlsdata4{13,3} = temp_style(6,1);
xlsdata4{13,4} = temp_style(6,3);
xlsdata4{13,5} = temp_style(6,5);
xlsdata4{13,6} = temp_style(6,7);
xlsdata4{13,7} = temp_style(6,9);

xlsdata4{14,3} = temp_style(7,2);
xlsdata4{14,4} = temp_style(7,4);
xlsdata4{14,5} = temp_style(7,6);
xlsdata4{14,6} = temp_style(7,8);
xlsdata4{14,7} = temp_style(7,10);
xlsdata4{15,3} = temp_style(7,1);
xlsdata4{15,4} = temp_style(7,3);
xlsdata4{15,5} = temp_style(7,5);
xlsdata4{15,6} = temp_style(7,7);
xlsdata4{15,7} = temp_style(7,9);
xlsdata4{15,8} = temp_style(7,11);
RandTraffic = makeData(N,WeightType,Distance,xlsdata4);

axes(handles.axes_result);
plot(1:length(RandTraffic),RandTraffic);
xlabel('随机车辆荷载流长度');ylabel('轴重/KN');
fid = fopen('RandTraffic.txt','wt'); 
fprintf(fid,'%g\n',RandTraffic);    
fclose(fid);
xlswrite('RandTraffic.xlsx',RandTraffic);
% --- Executes just before car is made visible.
function car_OpeningFcn(hObject, eventdata, handles, varargin)
%%
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to car (see VARARGIN)

% Choose default command line output for car
handles.output = hObject;
global main_handle;
main_handle = handles;
global car_table_data;
car_table_data = zeros(7,10);
car_table_data(:,3)=ones(7,1);
car_table_data(:,6)=ones(7,1).*1000;
global car_total;
car_total = 0;
global sel_list;
sel_list = {'对数正态','正态','双峰正态'};
load_style = load('style.mat');
main_handle.load_style = load_style.load_style;
global dis_info;
dis_info = [1 1 0 1000 0]';
set(handles.edit_dis_miu,'String',num2str(dis_info(2)));
set(handles.edit_dis_sigma,'String',num2str(dis_info(3)));
set(handles.edit_dis_max,'String',num2str(dis_info(4)));
set(handles.edit_dis_min,'String',num2str(dis_info(5)));
update_table();
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes car wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = car_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;





% --- Executes when entered data in editable cell(s) in table_car_per.
function table_car_per_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table_car_per (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)

col_index = eventdata.Indices(2);
row_index = eventdata.Indices(1);

global car_table_data;
global car_total;
car_total = str2double(get(handles.edit_car_total,'String'));
car_total = car_total(1);
temp_total = 0;
for i=1:numel(car_table_data(:,1))
    if i==row_index
        continue;
    end
    temp_total = temp_total+car_table_data(i,1);
end
table_data = get(hObject,'data');
if col_index==1
    if (temp_total+str2double(eventdata.NewData))<=100
        car_table_data(row_index,col_index) = str2double(eventdata.NewData);
        car_table_data(row_index,col_index+1) = car_total.*str2double(eventdata.NewData)./100;
        table_data{row_index,col_index+1} = num2str(round(car_total.*str2double(eventdata.NewData)./100));
    else
        car_table_data(row_index,col_index) =100-temp_total;
        car_table_data(row_index,col_index+1) = car_total.*(100-temp_total)./100;
        table_data{row_index,col_index} = num2str(100-temp_total);
        table_data{row_index,col_index+1} = num2str(car_total.*(100-temp_total)./100);
    end
elseif col_index == 8 || col_index == 9 || col_index == 10
    if car_table_data(row_index,3)==1 || car_table_data(row_index,3)==2
        table_data{row_index,col_index} = 'No need';
    else
        car_table_data(row_index,col_index) = str2double(eventdata.NewData);
    end
else
    car_table_data(row_index,col_index) = str2double(eventdata.NewData);
end
set(hObject,'data',table_data);





function edit_car_total_Callback(hObject, eventdata, handles)
% hObject    handle to edit_car_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global car_total;
% car_total = str2Int(handles.edit_car_total.String)
car_total = str2double(get(hObject,'String'));
global car_table_data;
table_data = get(handles.table_car_per,'data');
tablesize = size(car_table_data);
for i=1:tablesize(1)
     table_data{i,1} = num2str(car_table_data(i,1));
     table_data{i,2} = num2str(car_total.*car_table_data(i,1)./100);
end
set(handles.table_car_per,'data',table_data);
% Hints: get(hObject,'String') returns contents of edit_car_total as text
%        str2double(get(hObject,'String')) returns contents of edit_car_total as a double


% --- Executes during object creation, after setting all properties.
function edit_car_total_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_car_total (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
% global car_table_data;
% table_data = get(hObject,'data');
% tablesize = size(car_table_data);
% for i=1:tablesize(1)
%     for j=1:tablesize(2)
%         table_data{i,j} = num2str(car_table_data(i,j));
%     end
% end
% set(hObject,'data',table_data);


% --- Executes during object creation, after setting all properties.
function table_car_per_CreateFcn(hObject, eventdata, handles)
% hObject    handle to table_car_per (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1
 callback_sel_list(hObject, eventdata, handles);


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global sel_list;
set(hObject,'String',sel_list);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2
 callback_sel_list(hObject, eventdata, handles);
 
% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global sel_list;
set(hObject,'String',sel_list);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3
 callback_sel_list(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global sel_list;
set(hObject,'String',sel_list);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu4.
function popupmenu4_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu4 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu4
 callback_sel_list(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global sel_list;
set(hObject,'String',sel_list);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5
 callback_sel_list(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global sel_list;
set(hObject,'String',sel_list);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu6.
function popupmenu6_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu6 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu6
 callback_sel_list(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global sel_list;
set(hObject,'String',sel_list);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu7.
function popupmenu7_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu7 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu7
 callback_sel_list(hObject, eventdata, handles);

% --- Executes during object creation, after setting all properties.
function popupmenu7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
global sel_list;
set(hObject,'String',sel_list);
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu_dis.
function popupmenu_dis_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu_dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu_dis contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu_dis


% --- Executes during object creation, after setting all properties.
function popupmenu_dis_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu_dis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
list = {'对数正态','正态'};
set(hObject,'String',list);
% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dis_sigma_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dis_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dis_sigma as text
%        str2double(get(hObject,'String')) returns contents of edit_dis_sigma as a double


% --- Executes during object creation, after setting all properties.
function edit_dis_sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dis_sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dis_miu_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dis_miu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dis_miu as text
%        str2double(get(hObject,'String')) returns contents of edit_dis_miu as a double


% --- Executes during object creation, after setting all properties.
function edit_dis_miu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dis_miu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dis_max_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dis_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dis_max as text
%        str2double(get(hObject,'String')) returns contents of edit_dis_max as a double


% --- Executes during object creation, after setting all properties.
function edit_dis_max_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dis_max (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_dis_min_Callback(hObject, eventdata, handles)
% hObject    handle to edit_dis_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_dis_min as text
%        str2double(get(hObject,'String')) returns contents of edit_dis_min as a double


% --- Executes during object creation, after setting all properties.
function edit_dis_min_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_dis_min (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_style.
function button_style_Callback(hObject, eventdata, handles)
% hObject    handle to button_style (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% run('style');
global main_handle;
load_style = load('style.mat');
main_handle.load_style = load_style.load_style;
style(main_handle.load_style,main_handle);
