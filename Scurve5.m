function [t, q, qdot, q2dot] = Scurve5(pmax, vmax, amax)
% Dieu kien
% s_max > 2*a_max*t1^2 = 2*v_max^2/a_max
% v_max < sqrt(0.5*s_max*a_max)

if vmax > sqrt(pmax*amax/2);
    vmax = sqrt(pmax*amax/2)
    t1 = vmax/amax;
    tmax = 4*t1;
    t32 = 0;
else
    t1 = vmax/amax;
    t32 = (pmax-2*amax*t1^2)/vmax;
    tmax = 4*t1 + t32;
end


        if vmax > sqrt(pmax*amax/2)
        vmax = sqrt(pmax*amax/2);
    end
    
    t1 = vmax/amax;
    alpha = amax/t1;
    t2 = 2*t1;
    t3 = t2 + t32;
    t4 = t3 + t1;
    tmax = t3 + t2;
%   0-----t1-----t2----------t3-----t4-----tmax
    t = linspace(0, tmax, 100);
    q = zeros(size(t));
    qdot = zeros(size(t));
    q2dot = zeros(size(t));
    for i = 1:length(t)
        if t(i) <= t1
            q(i) = alpha*t(i)^3/6;      % q(end) = alpha*t1^3/6
            qdot(i) = alpha*t(i)^2/2;   % qdot(end) =  alpha*t1^2/2
            q2dot(i) = alpha*t(i);      % q2dot(end) = alpha*t1 = amax 
        elseif t(i) <= t2
            q(i) = alpha*t1^3/6 + amax*(t(i)-t1)^2/2 - alpha*(t(i)-t1)^3/6 + alpha*t1^2/2*(t(i)-t1) ;   % q(end) = amax*t1^2
            qdot(i) = alpha*t1^2/2 + amax*(t(i)-t1) - alpha*(t(i)-t1)^2/2;                              % qdot(end) =  vmax
            q2dot(i) = amax - alpha*(t(i)-t1);                                                          % q2dot(end) = 0 
        elseif t(i) <= t3
            q(i) =  amax*t1^2 + vmax*(t(i)-t2); % q(end) = amax*t1^2 + vmax*(t3-t2)
            qdot(i) = vmax;                     % qdot(end) =  vmax
            q2dot(i) = 0;                       % q2dot(end) = 0
        elseif t(i) <= t4
            q(i) = amax*t1^2 + vmax*(t3-t2) + vmax*(t(i)-t3) - alpha*(t(i)-t3)^3/6  % q(end) = amax*t1^2 + vmax*(t3-t2) + vmax*(t4-t3) - alpha*(t4-t3)^3/6 
            qdot(i) = vmax - alpha*(t(i)-t3)^2/2;                                   % qdot(end) =  vmax
            q2dot(i) = -alpha*(t(i)-t3);                                            % q2dot(end) = 0
        elseif t(i) <= tmax
            q(i) = pmax - alpha*(tmax - t(i))^3/6;
            qdot(i) = vmax - alpha*(t4-t3)^2/2 - amax*(t(i)-t4) + alpha*(t(i)-t4)^2/2;
            q2dot(i) = -amax + alpha*(t(i)-t4);
        end
    end
end