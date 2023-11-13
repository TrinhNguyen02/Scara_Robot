function [T] = Forward_Kinematics(n, a, alpha, d, theta) % ma tran bien doi T
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% T1 = DH_Matrix(a(1), alpha(1), d(1), theta(1));
% T2 = DH_Matrix(a(2), alpha(2), d(2), theta(2));
% T3 = DH_Matrix(a(3), alpha(3), d(3), theta(3));
% T4 = DH_Matrix(a(4), alpha(4), d(4), theta(4));
% T5 = DH_Matrix(a(5), alpha(5), d(5), theta(5));
% T = eye(4)*T1*T2*T3*T4*T5;

% 
    T(:,:,1) = eye(4);
    for i = 1:n
        DHm = DH_Matrix(a(i), alpha(i), d(i), theta(i));
        T(:,:,i+1) = T(:,:,i)*DHm;
    end
end

