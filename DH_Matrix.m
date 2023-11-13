function [T] = DH_Matrix(a, alpha, d, theta)        % ma tran Denavit- Hartenberg
%DH_MATRIX Summary of this function goes here
%   Detailed explanation goes here
    T = [cos(theta),    -sin(theta)*cos(alpha),     sin(theta)*sin(alpha),  a*cos(theta);
         sin(theta),    cos(theta)*cos(alpha),      -cos(theta)*sin(alpha), a*sin(theta);
         0,             sin(alpha),                 cos(alpha),             d;
         0,             0,                          0,                      1];
end

