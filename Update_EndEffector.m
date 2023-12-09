function Update_EndEffector(scara, handles)
%UPDATE_ENDEFFECTOR Summary of this function goes here
%   Detailed explanation goes here
    
    set(handles.xCurr, 'String', num2str(round(scara.EndEffector(1), 4)));
    set(handles.yCurr, 'String', num2str(round(scara.EndEffector(2), 4)));
    set(handles.zCurr, 'String', num2str(round(scara.EndEffector(3), 4)));
    set(handles.yawCurr, 'String', num2str(round(rad2deg(scara.EndEffector(4)), 2)));


end

