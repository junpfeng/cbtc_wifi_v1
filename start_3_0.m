function varargout = start_3_0(varargin)
% START_3_0 MATLAB code for start_3_0.fig
%      START_3_0, by itself, creates a new START_3_0 or raises the existing
%      singleton*.
%
%      H = START_3_0 returns the handle to a new START_3_0 or the handle to
%      the existing singleton*.
%
%      START_3_0('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in START_3_0.M with the given input arguments.
%
%      START_3_0('Property','Value',...) creates a new START_3_0 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before start_3_0_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to start_3_0_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help start_3_0

% Last Modified by GUIDE v2.5 21-Mar-2019 09:37:30

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @start_3_0_OpeningFcn, ...
                   'gui_OutputFcn',  @start_3_0_OutputFcn, ...
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


% --- Executes just before start_3_0 is made visible.
function start_3_0_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to start_3_0 (see VARARGIN)

% Choose default command line output for start_3_0
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes start_3_0 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.应该是初始化函数
function varargout = start_3_0_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cancelFlag; % 取消标志位，记录test.m窗口是由取消关闭（=1），还是确认关闭（=0）
cancelFlag = 0; % 全局变量的使用，需要在不同作用域申明一下全局。
conc = database('netdesign', 'root', '123', 'com.mysql.jdbc.Driver', 'jdbc:mysql://localhost:3306/netdesign');
curs = exec(conc, "select count from myreg");
curs = fetch(curs);
ShowNum = curs.Data;
set(handles.ShowNum, 'String', ShowNum{1});
close(conc);
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ImportButton.
function ImportButton_Callback(hObject, eventdata, handles)
% hObject    handle to ImportButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global cancelFlag;
cancelFlag = 0;
run('test.m');
if cancelFlag == 0
    count = str2double(get(handles.ShowNum, 'String')) + 1;
    set(handles.ShowNum, 'String', count); % 只有确认之后才能加一
end




% --- Executes on button press in reImportButton.
function reImportButton_Callback(hObject, eventdata, handles)
% hObject    handle to reImportButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% ---全部初始化----
% --------GUI 参数初始化
set(handles.ShowNum, 'String', 0);
global clearPlotFlag;
clearPlotFlag = 1;
% --------数据库初始化
clearDB();



% --- Executes on button press in simuButton.
function simuButton_Callback(hObject, eventdata, handles)
% hObject    handle to simuButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
n = str2double(get(handles.ShowNum, 'String'));
global px1 py1; % 轨道测试点画图 
global px2 py2; % AP可能点
global px3 py3; % 干扰基站
global px4 py4; % AP部署点
global clearPlotFlag;
clearPlotFlag = 1;
for i = 1:n
 %% 循环读取数据库和仿真
    % ---对存储数据库变量的初始化     
    [myObject, myEventdata] = varInitial();
    % ---读取数据库
    [myObject, myEventdata] = readMysql(i, myObject, myEventdata);
    % ---有些数据需要计算得来
    %       获取目标AP和轨道测试点的坐标 
            [myObject, myEventdata] = get_track(myObject, myEventdata);
    %       测试点的数量
            myObject.myTrack.TrackPoint = length(myObject.myTrack.TrackX);
    %       场景判别和模型选择
            [myObject, myEventdata] = cm_select(myObject, myEventdata);
            
%% 开始仿真---暴力搜索
    [myObject, myEventdata] = bf_search(myObject, myEventdata);
            
%% 验证结果
    [myObject, myEventdata] = outage_vaildate(myObject, myEventdata);
    
%% -----------集结坐标数据---------
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
end
% %% 画出仿真结果
% run('output_plot.m');



function ShowNum_Callback(hObject, eventdata, handles)
% hObject    handle to ShowNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ShowNum as text
%        str2double(get(hObject,'String')) returns contents of ShowNum as a double


% --- Executes during object creation, after setting all properties.
function ShowNum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShowNum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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


% --- Executes on button press in openSolution.
function openSolution_Callback(hObject, eventdata, handles)
% hObject    handle to openSolution (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
run('output_plot.m');

% --- Executes on button press in reImportButton.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to reImportButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
