function varargout = test(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @test_OpeningFcn, ...
                   'gui_OutputFcn',  @test_OutputFcn, ...
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


% --- Executes just before test is made visible.
function test_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to test (see VARARGIN)


handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes test wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = test_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.track_table,'Data',cell(1,4));
set(handles.AP_table,'Data',{'64.8','13'});
set(handles.rec_table,'Data',{'13','-100','-5'});
% track_cell = {'直线型','(0,0)','(120,10)','/','/';...
% '圆弧型','(120,10)','(200,100)','(140,100)','60';...
% '直线型','(200,100)','(210,200)','/','/'}; % 预先添加的数据,每种数据一行
% track_cell = {'直线型','(0,0)','(120,10)','/','/';...
% '圆弧型','(120,10)','(200,100)','(140,100)','60'}

track_cell = {'直线型','(-500,0)','(600,0)','/','/'};

% CircleCell={2, [120, 10], [200, 100],[140,100], pi/3};
% 第1段（第三段），起点坐标、终点坐标
% LineCell={1, [0, 0], [120, 10],...    
%           3, [200, 100], [210, 200] };
set(handles.track_table,'Data',track_cell);


% CircleCell={2, [120, 10], [200, 100],[140,100], pi/3};
% % 第1段（第三段），起点坐标、终点坐标
% LineCell={1, [0, 0], [120, 10],...    
%           3, [200, 100], [210, 200] };
% Get default command line output from handles structure
varargout{1} = handles.output;

% 自定义的格式转换函数，将坐标形式的字符串的x和y分别提取出来
function [x, y] = coordinate2xy(strxy)
% 输入的strxy是坐标的字符串形式
% 输出是 坐标的x轴和y轴的字符串形式
x = ''; y = ''; i = 1;% 初始化
if strxy(i) == '('
   i = i + 1;
   while strxy(i) ~= ','
       x = strcat(x,strxy(i));
       i = i + 1;
   end
end
if strxy(i) == ','
    i = i + 1;
    while strxy(i) ~= ')'
        y = strcat(y,strxy(i));
        i = i + 1;
    end
end
    

function popupmenu1_CreateFcn(hObject, eventdata, handles)
% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


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


% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes during object deletion, before destroying properties.
function track_table_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to track_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function interval_edit_Callback(hObject, eventdata, handles)
% hObject    handle to interval_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interval_edit as text
%        str2double(get(hObject,'String')) returns contents of interval_edit as a double


% --- Executes during object creation, after setting all properties.
function interval_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interval_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in track_table.
function track_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to track_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when selected cell(s) is changed in track_table.
function track_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to track_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function track_table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to track_table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in addtrack_button.
function addtrack_button_Callback(hObject, eventdata, handles)
% hObject    handle to addtrack_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
k = menu('选择要添加的轨道类型','直线型','圆弧型');
clear answer;
if k == 1
    answer = inputdlg({'起点坐标的x值','起点坐标的y值','终点坐标的x值','终点坐标的y值'}, 'add track');
    start = strcat('(',answer{1},',',answer{2},')'); ends = strcat('(',answer{3},',',answer{4},')');
    Oldframe = get(handles.track_table,'Data');
     frame = {'直线型',start,ends,'/','/'};
    if ~isempty(Oldframe{1}) 
        frame = [Oldframe;frame]; % 将原来的拼接起来
        set(handles.track_table,'Data',frame);
    else
        set(handles.track_table,'Data',frame);
    end
elseif k == 2
    answer = inputdlg({'起点坐标的x值','起点坐标的y值','终点坐标的x值','终点坐标的y值','圆心坐标的x值','圆心坐标的y值','圆心角（使用角度值）'}, 'add track');
    start = strcat('(',answer{1},',',answer{2},')'); ends = strcat('(',answer{3},',',answer{4},')'); O = strcat('(',answer{5},',',answer{6},')');
    degree = answer{7};
    Oldframe = get(handles.track_table,'Data');
     frame = {'圆弧型',start,ends,O,degree};
    if ~isempty(Oldframe{1}) 
        frame = [Oldframe;frame]; % 将原来的拼接起来
        set(handles.track_table,'Data',frame);
    else
        set(handles.track_table,'Data',frame);
    end
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over addtrack_button.
function addtrack_button_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to addtrack_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function threshold_edit_Callback(hObject, eventdata, handles)
% hObject    handle to threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of threshold_edit as text
%        str2double(get(hObject,'String')) returns contents of threshold_edit as a double


% --- Executes during object creation, after setting all properties.
function threshold_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to threshold_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_ok.
function button_ok_Callback(hObject, eventdata, handles)
% hObject    handle to button_ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function refer_edit_Callback(hObject, eventdata, handles)
% hObject    handle to refer_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of refer_edit as text
%        str2double(get(hObject,'String')) returns contents of refer_edit as a double


% --- Executes during object creation, after setting all properties.
function refer_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to refer_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function exp_edit_Callback(hObject, eventdata, handles)
% hObject    handle to exp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp_edit as text
%        str2double(get(hObject,'String')) returns contents of exp_edit as a double


% --- Executes during object creation, after setting all properties.
function exp_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function var0_edit_Callback(hObject, eventdata, handles)
% hObject    handle to var0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of var0_edit as text
%        str2double(get(hObject,'String')) returns contents of var0_edit as a double


% --- Executes during object creation, after setting all properties.
function var0_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var0_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function alpha_edit_Callback(hObject, eventdata, handles)
% hObject    handle to alpha_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of alpha_edit as text
%        str2double(get(hObject,'String')) returns contents of alpha_edit as a double


% --- Executes during object creation, after setting all properties.
function alpha_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alpha_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function beta_edit_Callback(hObject, eventdata, handles)
% hObject    handle to beta_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of beta_edit as text
%        str2double(get(hObject,'String')) returns contents of beta_edit as a double


% --- Executes during object creation, after setting all properties.
function beta_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to beta_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function interx1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to interx1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interx1_edit as text
%        str2double(get(hObject,'String')) returns contents of interx1_edit as a double


% --- Executes during object creation, after setting all properties.
function interx1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interx1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intery1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to intery1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intery1_edit as text
%        str2double(get(hObject,'String')) returns contents of intery1_edit as a double


% --- Executes during object creation, after setting all properties.
function intery1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intery1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function interx2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to interx2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of interx2_edit as text
%        str2double(get(hObject,'String')) returns contents of interx2_edit as a double


% --- Executes during object creation, after setting all properties.
function interx2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to interx2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function intery2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to intery2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of intery2_edit as text
%        str2double(get(hObject,'String')) returns contents of intery2_edit as a double


% --- Executes during object creation, after setting all properties.
function intery2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to intery2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inter1power_edit_Callback(hObject, eventdata, handles)
% hObject    handle to inter1power_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inter1power_edit as text
%        str2double(get(hObject,'String')) returns contents of inter1power_edit as a double


% --- Executes during object creation, after setting all properties.
function inter1power_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inter1power_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function inter2power_edit_Callback(hObject, eventdata, handles)
% hObject    handle to inter2power_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inter2power_edit as text
%        str2double(get(hObject,'String')) returns contents of inter2power_edit as a double


% --- Executes during object creation, after setting all properties.
function inter2power_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inter2power_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exert_pushbutton.
function exert_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to exert_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.console_edit,'String','运行中');pause(0.01);
% 数据处理
[myObject, myEventdata] = data_process(handles);
% 暴力搜索
[myObject, myEventdata] = bf_search(myObject, myEventdata);
% 验证结果
 [myObject, myEventdata] = outage_vaildate(myObject, myEventdata);
%% -----------集结坐标数据----------
global px1 py1; % 轨道测试点画图 
global px2 py2; % AP可能点
global px3 py3; % 干扰基站
global px4 py4; % AP部署点

px1 = myObject.myTrack.TrackX;   py1 = myObject.myTrack.TrackY;
px2 = myObject.myRtx.ApX;        py2 = myObject.myRtx.ApY;
px3 = myObject.myInterf.InterfX;  py3 = myObject.myInterf.InterfY;
px4 = 0;   py4 = 0;
%---解除最优部署的坐标的x和y的集合
for i = 1:myEventdata.ApM
    px4 = [px4, myEventdata.OptDeploy{1,i}(1)];
    py4 = [py4, myEventdata.OptDeploy{1,i}(2)];
end
px4 = px4(2:end); py4 = py4(2:end);

if myEventdata.IsOpt == 0 % 无最佳方案
    set(handles.console_edit,'String','无符合要求的最佳方案');
elseif myEventdata.IsOpt == 1
    set(handles.console_edit,'String','V1.1');
    run('output_plot.m');
end

%-----+++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------
%---------------------------------------------------------------------------
% --- Executes on button press in clearalltrack_button.
function clearalltrack_button_Callback(hObject, eventdata, handles)
% hObject    handle to clearalltrack_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
frame = {'','','','',''};
 set(handles.track_table,'Data',frame);



function step_edit_Callback(hObject, eventdata, handles)
% hObject    handle to step_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of step_edit as text
%        str2double(get(hObject,'String')) returns contents of step_edit as a double


% --- Executes during object creation, after setting all properties.
function step_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to step_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to num1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num1_edit as text
%        str2double(get(hObject,'String')) returns contents of num1_edit as a double


% --- Executes during object creation, after setting all properties.
function num1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function num2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to num2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of num2_edit as text
%        str2double(get(hObject,'String')) returns contents of num2_edit as a double


% --- Executes during object creation, after setting all properties.
function num2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to num2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function var1_edit_Callback(hObject, eventdata, handles)
% hObject    handle to var1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of var1_edit as text
%        str2double(get(hObject,'String')) returns contents of var1_edit as a double


% --- Executes during object creation, after setting all properties.
function var1_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var1_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function var2_edit_Callback(hObject, eventdata, handles)
% hObject    handle to var2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of var2_edit as text
%        str2double(get(hObject,'String')) returns contents of var2_edit as a double


% --- Executes during object creation, after setting all properties.
function var2_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to var2_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in open_plot.
function open_plot_Callback(hObject, eventdata, handles)
% hObject    handle to open_plot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% global x1 y1; % 轨道画图 
% global x2 y2; % AP可能点
% global x3 y3; % 干扰基站
% global x4 y4; % AP部署点
% x1 = 1:100; y1 = 1:100;
run('output_plot.m');



function console_edit_Callback(hObject, eventdata, handles)
% hObject    handle to console_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of console_edit as text
%        str2double(get(hObject,'String')) returns contents of console_edit as a double


% --- Executes during object creation, after setting all properties.
function console_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to console_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in SceneMenu.
function SceneMenu_Callback(hObject, eventdata, handles)
% hObject    handle to SceneMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns SceneMenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from SceneMenu


% --- Executes during object creation, after setting all properties.
function SceneMenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SceneMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in sureButton.
function sureButton_Callback(hObject, eventdata, handles)
% hObject    handle to sureButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 % ----这个键的功能和之前开始仿真键又很大的相关性---是最复杂和最关键的一步-------
% ---导入数据库----
import2mysql(handles);
% ---以导入的场景数加1---
% ---退出当前窗口
close(gcf); % gcf是指当前窗口


% --- Executes on button press in cancelButton.
function cancelButton_Callback(hObject, eventdata, handles)
% hObject    handle to cancelButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cancelFlag;
cancelFlag = 1;
close(gcf); % gcf是指当前窗口
