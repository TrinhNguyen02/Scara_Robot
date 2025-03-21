    function varargout = mySCARA(varargin)
% MYSCARA MATLAB code for mySCARA.fig
%      MYSCARA, by itself, creates a new MYSCARA or raises the existing
%      singleton*.
%
%      H = MYSCARA returns the handle to a new MYSCARA or the handle to
%      the existing singleton*.
%   
%      MYSCARA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYSCARA.M with the given input arguments.
%
%      MYSCARA('Property','Value',...) creates a new MYSCARA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mySCARA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mySCARA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mySCARA

% Last Modified by GUIDE v2.5 09-Dec-2023 15:01:12

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mySCARA_OpeningFcn, ...
                   'gui_OutputFcn',  @mySCARA_OutputFcn, ...
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


% --- Executes just before mySCARA is made visible.
function mySCARA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mySCARA (see VARARGIN)

% Choose default command line output for mySCARA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mySCARA wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% Setup for SCARA       ratio scale = 1/100
global scara



a     = [125/100        175/100     0           0   ];
alpha = [0              0           0           180 ];
d     = [(162.5+24)/100 0           74.5/100    0   ];
theta = [0              0           0           0   ];


% a     = [0 125/100 175/100 0 0];
% alpha = [0 0 180 0 0];
% d     = [(162.5+24)/100 0 0 74.5/100 0];
% theta = [0 0 0 0 0];
type = ['r', 'r', 'p', 'r'];
base = [0; 0; 0];
scara = Robot(a, alpha, d, theta, type, base);
scara = scara.set_joint_variable(1, deg2rad(get(handles.slider1_th1, 'Value')));
scara = scara.set_joint_variable(2, deg2rad(get(handles.slider2_th2, 'Value')));
scara = scara.set_joint_variable(3, get(handles.slider3_d3, 'Value'));
scara = scara.set_joint_variable(4, deg2rad(get(handles.slider4_th4, 'Value')));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));


% set(handles.edit1,'string', num2str(get(handles.slider1_th1,'value')));
% grid on
% RESET_Callback(hObject, eventdata, handles);
% space_select_Callback(hObject, eventdata, handles);


% --- Outputs from this function are returned to the command line.
function varargout = mySCARA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function slider1_th1_Callback(hObject, eventdata, handles)
% hObject    handle to slider1_th1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
set(handles.edit1,'string', num2str(get(handles.slider1_th1,'value')));
scara = scara.set_joint_variable(1, deg2rad(get(handles.slider1_th1, 'Value')));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));
    

% --- Executes during object creation, after setting all properties.
function slider1_th1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider1_th1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



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


% --- Executes on slider movement.
function slider2_th2_Callback(hObject, eventdata, handles)
% hObject    handle to slider2_th2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
set(handles.edit2,'string', num2str(get(handles.slider2_th2,'value')));
scara = scara.set_joint_variable(2, deg2rad(get(handles.slider2_th2, 'Value')));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));


% --- Executes during object creation, after setting all properties.
function slider2_th2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider2_th2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

s C
% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider3_d3_Callback(hObject, eventdata, handles)
% hObject    handle to slider3_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
set(handles.edit3,'string', num2str((get(handles.slider3_d3,'value')-0.745)));
scara = scara.set_joint_variable(3, get(handles.slider3_d3, 'Value'));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));


% --- Executes during object creation, after setting all properties.
function slider3_d3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider3_d3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider4_th4_Callback(hObject, eventdata, handles)
% hObject    handle to slider4_th4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
set(handles.edit4,'string', num2str(get(handles.slider4_th4,'value')));
scara = scara.set_joint_variable(4, deg2rad(get(handles.slider4_th4, 'Value')));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));



% --- Executes during object creation, after setting all properties.
function slider4_th4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider4_th4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Reset.
function Btn_Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara
    clear clc
    scara = scara.set_joint_variable(1, 0);
    scara = scara.set_joint_variable(2, 0);
    scara = scara.set_joint_variable(3, 0.745);
    scara = scara.set_joint_variable(4, 0);
    scara = scara.update();
    Update_EndEffector(scara, handles);
    scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));

    % -------Reset varible slider---------------% 
set(handles.slider1_th1, 'Value', 0);
set(handles.edit1,'string', num2str(get(handles.slider1_th1,'value')));
set(handles.slider2_th2, 'Value', 0);
set(handles.edit2,'string', num2str(get(handles.slider2_th2,'value')));
set(handles.slider3_d3, 'Value', 0.745);
set(handles.edit3,'string', num2str((get(handles.slider3_d3,'value')-0.745)));
set(handles.slider4_th4, 'Value', 0);
set(handles.edit4,'string', num2str(get(handles.slider4_th4,'value')));

set(handles.xSlider, 'Value', 0);
set(handles.xEdit,'string', num2str(3+ get(handles.xSlider,'value')));
set(handles.ySlider, 'Value', 0);
set(handles.yEdit,'string', num2str(get(handles.ySlider,'value')));
set(handles.zSlider, 'Value', 1.12);
set(handles.zEdit,'string', num2str(get(handles.zSlider,'value')));
set(handles.yawSlider, 'Value', 0);
set(handles.yawEdit,'string', num2str(get(handles.yawSlider,'value')));

% --- Executes on button press in Workspace.
function Workspace_Callback(hObject, eventdata, handles)
% hObject    handle to Workspace (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Workspace
global scara
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));



% --- Executes on button press in Coords.
function Coords_Callback(hObject, eventdata, handles)
% hObject    handle to Coords (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of Coords

global scara
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));



function xCurr_Callback(hObject, eventdata, handles)
% hObject    handle to xCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xCurr as text
%        str2double(get(hObject,'String')) returns contents of xCurr as a double


% --- Executes during object creation, after setting all properties.
function xCurr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yCurr_Callback(hObject, eventdata, handles)
% hObject    handle to yCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yCurr as text
%        str2double(get(hObject,'String')) returns contents of yCurr as a double


% --- Executes during object creation, after setting all properties.
function yCurr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zCurr_Callback(hObject, eventdata, handles)
% hObject    handle to zCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zCurr as text
%        str2double(get(hObject,'String')) returns contents of zCurr as a double


% --- Executes during object creation, after setting all properties.
function zCurr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rollCurr_Callback(hObject, eventdata, handles)
% hObject    handle to rollCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rollCurr as text
%        str2double(get(hObject,'String')) returns contents of rollCurr as a double


% --- Executes during object creation, after setting all properties.
function rollCurr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rollCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pitchCurr_Callback(hObject, eventdata, handles)
% hObject    handle to pitchCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitchCurr as text
%        str2double(get(hObject,'String')) returns contents of pitchCurr as a double


% --- Executes during object creation, after setting all properties.
function pitchCurr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitchCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yawCurr_Callback(hObject, eventdata, handles)
% hObject    handle to yawCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yawCurr as text
%        str2double(get(hObject,'String')) returns contents of yawCurr as a double


% --- Executes during object creation, after setting all properties.
function yawCurr_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yawCurr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Btn_Forward.
function Btn_Forward_Callback(hObject, eventdata, handles)
% hObject    handle to Btn_Forward (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara
Th1 = deg2rad(get(handles.slider1_th1, 'Value'));
Th2 = deg2rad(get(handles.slider2_th2, 'Value'));
D3  = get(handles.slider3_d3,'value')-0.745;
Th4 = deg2rad(get(handles.slider4_th4, 'Value'));
vMax = str2double(get(handles.vMax, 'String'));
aMax = str2double(get(handles.aMax, 'String'));
if isnan(vMax) || isnan(aMax)
    vMax = pi/6;
    aMax = pi/12;
end
vMax = vMax*pi/180;
aMax = aMax *pi/180;

contents = cellstr(get(handles.Trajectory, 'String'));
typeTrajectory = contents{get(handles.Trajectory, 'Value')};

if strcmp(typeTrajectory, 'LSPB')
%     [t, q, qdot, q2dot] = LSPB(qMax, vMax, aMax);
    [t, qTh1,  vTh1,  aTh1] = LSPB(Th1, vMax, aMax);
    [t, qTh2,  vTh2,  aTh2] = LSPB(Th2, vMax, aMax );
    [t, qD3,  vD3,  aD3]    = LSPB(D3, 0.1, 1);
    [t, qTh4,  vTh4,  aTh4] = LSPB(Th4, vMax, aMax);
elseif strcmp(typeTrajectory, 'Scurve5')
    [t, qTh1,  vTh1,  aTh1] = Scurve5(Th1, vMax, aMax);
    [t, qTh2,  vTh2,  aTh2] = Scurve5(Th2, vMax, aMax);
    [t, qD3,  vD3,  aD3]    = Scurve5(D3, 0.1, 1);
    [t, qTh4,  vTh4,  aTh4] = Scurve5(Th4, vMax, aMax);

elseif strcmp(typeTrajectory, 'Scurve7')
    [t, qTh1,  vTh1,  aTh1] = Scurve7(Th1, vMax, aMax);
    [t, qTh2,  vTh2,  aTh2] = Scurve7(Th2, vMax, aMax);
    [t, qD3,  vD3,  aD3]    = Scurve7(D3, 0.1, 1);
    [t, qTh4,  vTh4,  aTh4] = Scurve7(Th4, vMax, aMax);
end

    pEEF = zeros(4, length(t));
    joint =  zeros(4, length(t));
    joint(1,:) = linspace(0,Th1 ,length(t));
    joint(2,:) = linspace(0,Th2,length(t));
    joint(3,:) = linspace(0,D3 ,length(t));
    joint(4,:) = linspace(0,Th4,length(t));


for i = 1:length(t)

   set(handles.Btn_Forward,'Enable','off','String', 'Not Push');

    scara = scara.set_joint_variable(1, joint(1,i));
    scara = scara.set_joint_variable(2, joint(2,i));
    scara = scara.set_joint_variable(3, joint(3,i)+0.745);
    scara = scara.set_joint_variable(4, joint(4,i));
    scara = scara.update();
    Update_EndEffector(scara, handles);
    scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));
    pEEF(:,i) = scara.EndEffector;


    plot(handles.axes_Th1, t(1:i), qTh1(1:i), 'b-');
    grid(handles.axes_Th1, 'on');
    plot(handles.axes_vTh1, t(1:i) , vTh1(1:i), 'b-');
    grid(handles.axes_vTh1, 'on');
    plot(handles.axes_aTh1 , t(1:i), aTh1(1:i), 'b-');
    grid(handles.axes_aTh1, 'on');

    plot(handles. axes_Th2, t(1:i), qTh2(1:i), 'b-');
    grid(handles. axes_Th2, 'on');
    plot(handles.axes_vTh2, t(1:i), vTh2(1:i), 'b-');
    grid(handles.axes_vTh2, 'on');
    plot(handles.axes_aTh2 , t(1:i), aTh2(1:i), 'b-');
    grid(handles.axes_aTh2, 'on');


    plot(handles.axes_D3, t(1:i), qD3(1:i), 'b-');
    grid(handles.axes_D3, 'on');
    plot(handles.axes_vD3, t(1:i), vD3(1:i), 'b-');
    grid(handles.axes_vD3, 'on');
    plot(handles.axes_aD3 , t(1:i), aD3(1:i), 'b-');
    grid(handles.axes_aD3, 'on');


    plot(handles.axes_Th4, t(1:i), qTh4(1:i), 'b-');
    grid(handles.axes_Th4, 'on');
    plot(handles.axes_vTh4, t(1:i), vTh4(1:i), 'b-');
    grid(handles.axes_vTh4, 'on');
    plot(handles.axes_aTh4 , t(1:i), aTh4(1:i), 'b-');
    grid(handles.axes_aTh4, 'on');

        
    plot(handles.axes_pX, t(1:i), pEEF(1,1:i), 'b-');
    grid(handles.axes_pX, 'on');
    plot(handles.axes_pY, t(1:i), pEEF(2,1:i), 'b-');
    grid(handles.axes_pY, 'on');
    plot(handles.axes_pZ , t(1:i), pEEF(3,1:i), 'b-');
    grid(handles.axes_pZ, 'on');    
  
    plot3(handles.axes1, pEEF(1,1:i), pEEF(2,1:i), pEEF(3,1:i), 'LineWidth', 2, 'Color', [0.9 0.1 0.1]);
    pause(0.00001)
end

    
set(handles.Btn_Forward,'Enable','on','String', 'Forward');




% --- Executes on slider movement.
function ySlider_Callback(hObject, eventdata, handles)
% hObject    handle to ySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.yEdit,'string', num2str(get(handles.ySlider,'value')));
global scara
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EndEffector =  [(3 + get(handles.xSlider,'value')), get(handles.ySlider,'value'), get(handles.zSlider,'value') , get(handles.yawSlider,'value')];
joint = Inverse_Kinematics(scara.a, scara.alpha, scara.d, scara.theta, EndEffector);
    scara = scara.set_joint_variable(1, joint(1));
    scara = scara.set_joint_variable(2, joint(2));
    scara = scara.set_joint_variable(3, joint(3));
    scara = scara.set_joint_variable(4, joint(4));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));


% --- Executes during object creation, after setting all properties.
function ySlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ySlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end






% --- Executes on slider movement.
function zSlider_Callback(hObject, eventdata, handles)
% hObject    handle to zSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
global scara
set(handles.zEdit,'string', num2str(get(handles.zSlider,'value')));

EndEffector =  [(3 + get(handles.xSlider,'value')), get(handles.ySlider,'value'),get(handles.zSlider,'value') , get(handles.yawSlider,'value')];
joint = Inverse_Kinematics(scara.a, scara.alpha, scara.d, scara.theta, EndEffector);
    scara = scara.set_joint_variable(1, joint(1));
    scara = scara.set_joint_variable(2, joint(2));
    scara = scara.set_joint_variable(3, joint(3));
    scara = scara.set_joint_variable(4, joint(4));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));

% --- Executes during object creation, after setting all properties.
function zSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



% --- Executes on slider movement.
function yawSlider_Callback(hObject, eventdata, handles)
% hObject    handle to yawSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
set(handles.yawEdit,'string', num2str(get(handles.yawSlider,'value')));
global scara

EndEffector =  [(3 + get(handles.xSlider,'value')), get(handles.ySlider,'value'),get(handles.zSlider,'value') , get(handles.yawSlider,'value')];
joint = Inverse_Kinematics(scara.a, scara.alpha, scara.d, scara.theta, EndEffector);
    scara = scara.set_joint_variable(1, joint(1));
    scara = scara.set_joint_variable(2, joint(2));
    scara = scara.set_joint_variable(3, joint(3));
    scara = scara.set_joint_variable(4, joint(4));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));


% --- Executes during object creation, after setting all properties.
function yawSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yawSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end




% --- Executes on slider movement.
function xSlider_Callback(hObject, eventdata, handles)
% hObject    handle to xSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.xEdit,'string', num2str(3+ get(handles.xSlider,'value')));
global scara
% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
EndEffector =  [(3 + get(handles.xSlider,'value')), get(handles.ySlider,'value'), get(handles.zSlider,'value') , get(handles.yawSlider,'value')];
joint = Inverse_Kinematics(scara.a, scara.alpha, scara.d, scara.theta, EndEffector);
    scara = scara.set_joint_variable(1, joint(1));
    scara = scara.set_joint_variable(2, joint(2));
    scara = scara.set_joint_variable(3, joint(3));
    scara = scara.set_joint_variable(4, joint(4));
scara = scara.update();
Update_EndEffector(scara, handles);
scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));

% --- Executes during object creation, after setting all properties.
function xSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


function xEdit_Callback(hObject, eventdata, handles)
% hObject    handle to xedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xedit as text
%        str2double(get(hObject,'String')) returns contents of xedit as a double


% --- Executes during object creation, after setting all properties.
function xEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yEdit_Callback(hObject, eventdata, handles)
% hObject    handle to yEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yEdit as text
%        str2double(get(hObject,'String')) returns contents of yEdit as a double


% --- Executes during object creation, after setting all properties.
function yEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zEdit_Callback(hObject, eventdata, handles)
% hObject    handle to zEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zEdit as text
%        str2double(get(hObject,'String')) returns contents of zEdit as a double


% --- Executes during object creation, after setting all properties.
function zEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yawEdit_Callback(hObject, eventdata, handles)
% hObject    handle to yawEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yawEdit as text
%        str2double(get(hObject,'String')) returns contents of yawEdit as a double


% --- Executes during object creation, after setting all properties.
function yawEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yawEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xNext_Callback(hObject, eventdata, handles)
% hObject    handle to xNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xNext as text
%        str2double(get(hObject,'String')) returns contents of xNext as a double


% --- Executes during object creation, after setting all properties.
function xNext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yNext_Callback(hObject, eventdata, handles)
% hObject    handle to yNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yNext as text
%        str2double(get(hObject,'String')) returns contents of yNext as a double


% --- Executes during object creation, after setting all properties.
function yNext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zNext_Callback(hObject, eventdata, handles)
% hObject    handle to zNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zNext as text
%        str2double(get(hObject,'String')) returns contents of zNext as a double


% --- Executes during object creation, after setting all properties.
function zNext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function rollNext_Callback(hObject, eventdata, handles)
% hObject    handle to rollNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of rollNext as text
%        str2double(get(hObject,'String')) returns contents of rollNext as a double


% --- Executes during object creation, after setting all properties.
function rollNext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to rollNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pitchNext_Callback(hObject, eventdata, handles)
% hObject    handle to pitchNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of pitchNext as text
%        str2double(get(hObject,'String')) returns contents of pitchNext as a double


% --- Executes during object creation, after setting all properties.
function pitchNext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pitchNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function yawNext_Callback(hObject, eventdata, handles)
% hObject    handle to yawNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yawNext as text
%        str2double(get(hObject,'String')) returns contents of yawNext as a double


% --- Executes during object creation, after setting all properties.
function yawNext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yawNext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in motionBtn.
function motionBtn_Callback(hObject, eventdata, handles)
% hObject    handle to motionBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara
pC = zeros(1, 4);
pC(1) = str2double(get(handles.xCurr, 'String'));
pC(2) = str2double(get(handles.yCurr, 'String'));
pC(3) = str2double(get(handles.zCurr, 'String'));
pC(4) = deg2rad(str2double(get(handles.yawCurr, 'String')));

pN = zeros(1, 4);
pN(1) = str2double(get(handles.xNext, 'String'));
pN(2) = str2double(get(handles.yNext, 'String'));
pN(3) = str2double(get(handles.zNext, 'String'));
pN(4) = deg2rad(str2double(get(handles.yawNext, 'String')));


vMax = str2double(get(handles.vMax, 'String'));
aMax = str2double(get(handles.aMax, 'String'));
tMax = str2double(get(handles.tMax, 'String'));
qMax = sqrt((pN(1) - pC(1))^2 + (pN(2) - pC(2))^2 + (pN(3) - pC(3))^2);

jointCurr = Inverse_Kinematics(scara.a, scara.alpha, scara.d, scara.theta, pC)
jointNext = Inverse_Kinematics(scara.a, scara.alpha, scara.d, scara.theta, pN)

qTh1Max = abs(jointNext(1)- jointCurr(1));
qTh2Max = abs(jointNext(2)- jointCurr(2));
qD3Max = abs(jointNext(3)- jointCurr(3));
qTh4Max = abs(jointNext(4)- jointCurr(4));
vMax = str2double(get(handles.vMax, 'String'));
aMax = str2double(get(handles.aMax, 'String'));
if isnan(vMax) || isnan(aMax)
    vMax = pi/6;
    aMax = pi/12;
end
vMax = vMax*pi/180;
aMax = aMax *pi/180;


contents = cellstr(get(handles.Trajectory, 'String'));
typeTrajectory = contents{get(handles.Trajectory, 'Value')};

if strcmp(typeTrajectory, 'LSPB')
%     [t, q, qdot, q2dot] = LSPB(qMax, vMax, aMax);
    [t, qTh1,  vTh1,  aTh1] = LSPB(qTh1Max, vMax, aMax);
    [t, qTh2,  vTh2,  aTh2] = LSPB(qTh2Max, vMax, aMax);
    [t, qD3,  vD3,  aD3]    = LSPB(qD3Max, 0.1, 1);
    [t, qTh4,  vTh4,  aTh4] = LSPB(qTh4Max, vMax, aMax);
elseif strcmp(typeTrajectory, 'Scurve5')
%     [t, q, qdot, q2dot] = Scurve5(qMax, vMax, aMax);
    [t, qTh1,  vTh1,  aTh1] = Scurve5(qTh1Max, vMax, aMax);
    [t, qTh2,  vTh2,  aTh2] = Scurve5(qTh2Max, vMax, aMax);
    [t, qD3,  vD3,  aD3]    = Scurve5(qD3Max, 0.1, 1);
    [t, qTh4,  vTh4,  aTh4] = Scurve5(qTh4Max, vMax, aMax);

elseif strcmp(typeTrajectory, 'Scurve7')
%     [t, q, qdot, q2dot] = Scurve7(qMax, vMax, aMax);
    [t, qTh1,  vTh1,  aTh1] = Scurve7(qTh1Max, vMax, aMax);
    [t, qTh2,  vTh2,  aTh2] = Scurve7(qTh2Max, vMax, aMax);
    [t, qD3,  vD3,  aD3]    = Scurve7(qD3Max, 0.1, 1);
    [t, qTh4,  vTh4,  aTh4] = Scurve7(qTh4Max, vMax, aMax);
end

    pEEF = zeros(4, length(t));
    joint =  zeros(4, length(t));
    joint(1,:) = linspace(jointCurr(1),jointNext(1) ,length(t));
    joint(2,:) = linspace(jointCurr(2),jointNext(2) ,length(t));
    joint(3,:) = linspace(jointCurr(3),jointNext(3) ,length(t));
    joint(4,:) = linspace(jointCurr(4),jointNext(4) ,length(t));


for i = 1:length(t)

    set(handles.motionBtn,'Enable','off','String', 'Not Push');

    scara = scara.set_joint_variable(1, joint(1,i));
    scara = scara.set_joint_variable(2, joint(2,i));
    scara = scara.set_joint_variable(3, joint(3,i));
    scara = scara.set_joint_variable(4, joint(4,i));
    scara = scara.update();
    Update_EndEffector(scara, handles);
    scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));
    pEEF(:,i) = scara.EndEffector;


    plot(handles.axes_Th1, t(1:i), qTh1(1:i), 'b-');
    grid(handles.axes_Th1, 'on');
    plot(handles.axes_vTh1, t(1:i) , vTh1(1:i), 'b-');
    grid(handles.axes_vTh1, 'on');
    plot(handles.axes_aTh1 , t(1:i), aTh1(1:i), 'b-');
    grid(handles.axes_aTh1, 'on');

    plot(handles. axes_Th2, t(1:i), qTh2(1:i), 'b-');
    grid(handles. axes_Th2, 'on');
    plot(handles.axes_vTh2, t(1:i), vTh2(1:i), 'b-');
    grid(handles.axes_vTh2, 'on');
    plot(handles.axes_aTh2 , t(1:i), aTh2(1:i), 'b-');
    grid(handles.axes_aTh2, 'on');


    plot(handles.axes_D3, t(1:i), qD3(1:i), 'b-');
    grid(handles.axes_D3, 'on');
    plot(handles.axes_vD3, t(1:i), vD3(1:i), 'b-');
    grid(handles.axes_vD3, 'on');
    plot(handles.axes_aD3 , t(1:i), aD3(1:i), 'b-');
    grid(handles.axes_aD3, 'on');


    plot(handles.axes_Th4, t(1:i), qTh4(1:i), 'b-');
    grid(handles.axes_Th4, 'on');
    plot(handles.axes_vTh4, t(1:i), vTh4(1:i), 'b-');
    grid(handles.axes_vTh4, 'on');
    plot(handles.axes_aTh4 , t(1:i), aTh4(1:i), 'b-');
    grid(handles.axes_aTh4, 'on');

        
        
    plot(handles.axes_pX, t(1:i), pEEF(1,1:i), 'b-');
    grid(handles.axes_pX, 'on');
    plot(handles.axes_pY, t(1:i), pEEF(2,1:i), 'b-');
    grid(handles.axes_pY, 'on');
    plot(handles.axes_pZ , t(1:i), pEEF(3,1:i), 'b-');
    grid(handles.axes_pZ, 'on');   

    plot3(handles.axes1, pEEF(1,1:i), pEEF(2,1:i), pEEF(3,1:i), 'LineWidth', 2, 'Color', [0.9 0.1 0.1]);
    pause(0.00001)
end
    
    set(handles.motionBtn,'Enable','on','String', 'Go to');


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function vMax_Callback(hObject, eventdata, handles)
% hObject    handle to vMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vMax as text
%        str2double(get(hObject,'String')) returns contents of vMax as a double


% --- Executes during object creation, after setting all properties.
function vMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aMax_Callback(hObject, eventdata, handles)
% hObject    handle to aMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aMax as text
%        str2double(get(hObject,'String')) returns contents of aMax as a double


% --- Executes during object creation, after setting all properties.
function aMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function tMax_Callback(hObject, eventdata, handles)
% hObject    handle to tMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of tMax as text
%        str2double(get(hObject,'String')) returns contents of tMax as a double


% --- Executes during object creation, after setting all properties.
function tMax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to tMax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on mouse motion over figure - except title and menu.
function figure1_WindowButtonMotionFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in Trajectory.
function Trajectory_Callback(hObject, eventdata, handles)
% hObject    handle to Trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns Trajectory contents as cell array
%        contents{get(hObject,'Value')} returns selected item from Trajectory


% --- Executes during object creation, after setting all properties.
function Trajectory_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Trajectory (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in typePlot.
function typePlot_Callback(hObject, eventdata, handles)
% hObject    handle to typePlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns typePlot contents as cell array
%        contents{get(hObject,'Value')} returns selected item from typePlot
    contents = cellstr(get(handles.typePlot, 'String'));
    typePlot = contents{get(handles.typePlot, 'Value')};
if strcmp(typePlot, 'S-V-A')
    set(handles.svaPlot, 'Visible', 'on');
    set(handles.xyzPlot, 'Visible', 'off');
    set(handles.jointPlot, 'Visible', 'off');
elseif strcmp(typePlot, 'Tool_Space')
    set(handles.xyzPlot, 'Visible', 'on');
    set(handles.svaPlot, 'Visible', 'off');
    set(handles.jointPlot, 'Visible', 'off');
elseif strcmp(typePlot, 'Joint_Space')
    set(handles.jointPlot, 'Visible', 'on');
    set(handles.xyzPlot, 'Visible', 'off');
    set(handles.svaPlot, 'Visible', 'off');

end


% --- Executes during object creation, after setting all properties.
function typePlot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to typePlot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in dhBtn.
function dhBtn_Callback(hObject, eventdata, handles)
% hObject    handle to dhBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global scara
table((1:scara.n)', scara.a', scara.alpha', scara.d', scara.theta', 'VariableNames', {'Joint', 'a', 'alpha', 'd', 'theta'})
