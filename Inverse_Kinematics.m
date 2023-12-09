function q = Inverse_Kinematics(a, alpha, d, theta, EndEffector)
    % [x; y; z; roll; pitch; yaw] = EndEffector
    
    s = EndEffector(1)^2 + EndEffector(2)^2;
    % Check condition
    if sqrt(s) > a(1) + a(2) || sqrt(s) < abs(a(1) - a(2))
        warndlg('Inverse Kinematics Condition!', 'Warning');
    end
   
    c2 = (s - a(1)^2 - a(2)^2)/(2*a(1)*a(2));
    s2 = sqrt(1 - c2^2);
    q(2) = atan2(s2, c2);
    s1 = ((a(1)+a(2)*c2)*EndEffector(2) - a(2)*s2*EndEffector(1))/s;
    c1 = ((a(1)+a(2)*c2)*EndEffector(1) + a(2)*s2*EndEffector(2))/s;
    q(1) = atan2(s1, c1);
    q(4) = EndEffector(4)- q(1)-q(2);
    q(3) = d(1) - EndEffector(3);
    
    % Check condition
    if (q(1) > deg2rad(125))
        q(1) = deg2rad(125);
        warndlg('Inverse Kinematics Condition!', 'Warning');
%     elseif (q(1) < deg2rad(-62) && q(1) > deg2rad(-118))
%         q(1) = deg2rad(-62);
%         warndlg('Inverse Kinematics Condition!', 'Warning');
    end
    if (q(2) > deg2rad(145))
        q(2) = deg2rad(145);
        warndlg('Inverse Kinematics Condition!', 'Warning');
%     elseif (q(2) < deg2rad(-145))
%         q(2) = deg2rad(-145);
%         warndlg('Inverse Kinematics Condition!', 'Warning');
    end
end
