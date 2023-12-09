function  plotTh1(i , t, qTh1,  vTh1,  aTh1)
    plot(handles.axes_Th1, t(1:i), qTh1(1:i), 'b-');
    grid(handles.axes_Th1, 'on');
    plot(handles.axes_vTh1, t(1:i), vTh1(1,i), 'b-');
    grid(handles.axes_vTh1, 'on');
    plot(handles.axes_aTh1 , t(1:i), aTh1(1:i), 'b-');
    grid(handles.axes_aTh1, 'on');
end

