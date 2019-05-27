function varargout = output_plot(varargin)
% OUTPUT_PLOT MATLAB code for output_plot.fig
%      OUTPUT_PLOT, by itself, creates a new OUTPUT_PLOT or raises the existing
%      singleton*.
%
%      H = OUTPUT_PLOT returns the handle to a new OUTPUT_PLOT or the handle to
%      the existing singleton*.
%
%      OUTPUT_PLOT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in OUTPUT_PLOT.M with the given input arguments.
%
%      OUTPUT_PLOT('Property','Value',...) creates a new OUTPUT_PLOT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before output_plot_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to output_plot_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help output_plot

% Last Modified by GUIDE v2.5 01-Jan-2019 15:49:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @output_plot_OpeningFcn, ...
                   'gui_OutputFcn',  @output_plot_OutputFcn, ...
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


% --- Executes just before output_plot is made visible.
function output_plot_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to output_plot (see VARARGIN)
% axis equal;
global clearPlotFlag;
if clearPlotFlag == 1
    clearPlotFlag = 0;
    hold off;
end
global px1 py1; % 轨道测试点画图 
global px2 py2; % AP可能点
global px3 py3; % 干扰基站
global px4 py4; % AP部署点
plot(handles.track_axes,px1,py1,'+'); hold on;
plot(handles.track_axes,px2,py2,'X'); hold on;
plot(handles.track_axes,px3,py3,'O'); hold on;
plot(handles.track_axes,px4,py4,'V'); hold on;
% Choose default command line output for output_plot
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes output_plot wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = output_plot_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in p1.
function p1_Callback(hObject, eventdata, handles)
% hObject    handle to p1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% x1 = 1:100; y1 = 1:100;
% x2 = 1:200; y2 = 1:200;
% plot(handles.track_axes,2*x1,y1);
% plot(handles.track_axes,x2,y2);
