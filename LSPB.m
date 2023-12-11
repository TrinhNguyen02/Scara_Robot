function [t, q, qdot, q2dot] = LSPB(pmax, vmax, amax)
%     p = q     
%     v = q' (qdot)
%     a = q" (q2dot)
pmax = abs(pmax)
if vmax > sqrt(pmax*amax)
    vmax = sqrt(pmax*amax);
end
    t1 = vmax/amax;
    tmax = (pmax - vmax*t1)/(vmax) + 2*t1;      %     pmax = 2S1 + S2 = 2*(amax*t1^2/2) + vmax*tmax
                                                %     ==> tmax = (pmax - amax*t1^2)/vmax      ma amax*t1 = vmax
                                                %     ==> tmax = (pmax - vmax*t1)/(vmax) + 2*t1
    
    t2 = tmax - t1;

    t = linspace(0, tmax, 100);
    q = zeros(size(t));
    qdot = zeros(size(t));
    q2dot = zeros(size(t));

    for i = 1:length(t)
        if t(i) <= t1
            q(i) = amax*t(i)^2/2;
            qdot(i) = amax*t(i);
            q2dot(i) = amax;
        elseif t(i) <= tmax - t1
            q(i) = amax*t1^2/2 + vmax*(t(i)-t1); 
            qdot(i) = vmax;
            q2dot(i) = 0;
        elseif t(i) <= tmax
            q(i) = amax*t1^2/2 + vmax*(t2-t1) + vmax*(t(i)-t2) - amax*(t(i)-t2).*(t(i)-t2)/2;
            qdot(i) = vmax - amax * (t(i) - t2);
            q2dot(i) = -amax;
        end
    end

end
