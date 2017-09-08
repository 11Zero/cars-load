function varargout = style(varargin)
% STYLE MATLAB code for style.fig
%      STYLE, by itself, creates a new STYLE or raises the existing
%      singleton*.
%
%      H = STYLE returns the handle to a new STYLE or the handle to
%      the existing singleton*.
%
%      STYLE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STYLE.M with the given input arguments.
%
%      STYLE('Property','Value',...) creates a new STYLE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before style_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to style_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help style

% Last Modified by GUIDE v2.5 23-Aug-2017 13:04:47

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @style_OpeningFcn, ...
                   'gui_OutputFcn',  @style_OutputFcn, ...
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

function update_table()
global load_style;
global main_handles;
table_size = size(load_style);
table_data = get(main_handles.table_style,'data');
for i=1:table_size(1)
    for j=1:table_size(2)
        if i<=3 && j >3
            table_data{i,j}='No need';
        elseif i==4 && j>5
            table_data{i,j}='No need';
        elseif i==5 && j>7
            table_data{i,j}='No need';
        elseif i==6 && j>9
            table_data{i,j}='No need';
        else
            table_data{i,j} = num2str(load_style(i,j));
        end
    end
end
set(main_handles.table_style,'data',table_data);



% --- Executes just before style is made visible.
function style_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to style (see VARARGIN)

% Choose default command line output for style
handles.output = hObject;
global main_handles ;
main_handles = handles;
global load_style;
load_style = varargin{1};
global fathar_handles;
fathar_handles =  varargin{1};
update_table();
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes style wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = style_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in button_ok.
function button_ok_Callback(hObject, eventdata, handles)
% hObject    handle to button_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fathar_handles;
global load_style;
global main_handles;
table_data = get(main_handles.table_style,'data');
table_size = size(table_data);
load_style=zeros(table_size);
for i=1:table_size(1)
    for j=1:table_size(2)
        if strcmp(table_data{i,j},'No need')
            break;
        else
            load_style(i,j) = str2double(table_data{i,j});
        end
    end
end
fathar_handles.load_style = load_style;
save('style.mat','load_style'); 
close;


% --- Executes on button press in button_cancel.
function button_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to button_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close;


% --- Executes during object creation, after setting all properties.
function table_style_CreateFcn(hObject, eventdata, handles)
% hObject    handle to table_style (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called



% --- Executes when entered data in editable cell(s) in table_style.
function table_style_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to table_style (see GCBO)
% eventdata  structure with the following fields (see UITABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
col_index = eventdata.Indices(2);
row_index = eventdata.Indices(1);
table_data = get(hObject,'data');
table_size  = size(table_data);
value = str2double(eventdata.NewData);
total_per = 0;
for i=1:table_size(2)
    if i==col_index || rem(i,2)==0
        continue;
    end
    if strcmp('No need',table_data{row_index,i})
        break;
    end
    total_per = total_per+str2double(table_data{row_index,i});
end
if row_index<=3 && col_index >3
    table_data{row_index,col_index}='No need';
elseif row_index==4 && col_index>5
    table_data{row_index,col_index}='No need';
elseif row_index==5 && col_index>7
    table_data{row_index,col_index}='No need';
elseif row_index==6 && col_index>9
    table_data{row_index,col_index}='No need';
else
    if rem(col_index,2)==1 && (value+total_per)>1
        table_data{row_index,col_index}=num2str(1-total_per);
    else%出现修改轴距时无效问题
        table_data{row_index,col_index}=num2str(value);
    end
end
set(hObject,'data',table_data);
    
    
    
