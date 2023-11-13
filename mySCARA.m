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

% Last Modified by GUIDE v2.5 13-Nov-2023 11:19:58

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
grid on
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
Th1 = get(handles.slider1_th1, 'Value');
Th2 = get(handles.slider2_th2, 'Value');
D3  = get(handles.slider3_d3,'value')-0.745;
Th4 = get(handles.slider4_th4, 'Value');

for k=0:60
    Th1Temp = Th1*k/60;
    Th2Temp = Th2*k/60;
    D3Temp = D3*k/60+ 0.745;
    Th4Temp = Th4*k/60;
    scara = scara.set_joint_variable(1, deg2rad(Th1Temp));
    scara = scara.set_joint_variable(2, deg2rad(Th2Temp));
    scara = scara.set_joint_variable(3, D3Temp);
    scara = scara.set_joint_variable(4, deg2rad(Th4Temp));
    scara = scara.update();
    Update_EndEffector(scara, handles);
    scara.plot(handles.axes1, get(handles.Coords,'Value'), get(handles.Workspace,'Value'));

   set(handles.Btn_Forward,'Enable','off','String', 'Not Push');

end
set(handles.Btn_Forward,'Enable','on','String', 'Forward');


% --- Executes on slider movement.
function slider10_Callback(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider11_Callback(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider12_Callback(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function edit43_Callback(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit43 as text
%        str2double(get(hObject,'String')) returns contents of edit43 as a double


% --- Executes during object creation, after setting all properties.
function edit43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on slider movement.
function slider13_Callback(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider


% --- Executes during object creation, after setting all properties.
function slider13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to slider13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
