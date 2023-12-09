function [t, q, qdot, q2dot] = Scurvmaxe7(pmax, vmax, amax)
jmax = 2/6*pi;
if amax > (1/2*pmax*jmax^2)^(1/3)
    amax = (1/2*pmax*jmax^2)^(1/3);
    vmax = amax^2/jmax;
elseif vmax < amax^2/jmax
    vmax = amax^2/jmax;
elseif vmax > sqrt(1/4*amax^4/jmax^2 + pmax*amax) - 1/2*amax^2/jmax
    vmax = sqrt(1/4*amax^4/jmax^2 + pmax*amax) - 1/2*amax^2/jmax;
end


tc = amax/jmax;
ta_m = (vmax - jmax*tc^2)/amax;
q3 = jmax*tc^3 + 3/2*jmax*ta_m*tc^2 + 1/2*jmax*ta_m^2*tc;
tm = (pmax-2*q3)/vmax;
% Trajectory planning
t1 = tc;
t2 = t1 + ta_m;
t3 = t2 + tc;
t4 = t3 + tm;
t5 = t4 + tc;
t6 = t5 + ta_m;
tf = t6 + tc;
t = 0:tf/100:tf;
for i = 1:length(t)
    if t(i) < t1
        j(i) = jmax;
        q2dot(i) = jmax*t(i);
        qdot(i) = 1/2*jmax*t(i)^2;
        q(i) = 1/6*jmax*t(i)^3;
    elseif t(i) < t2
        j(i) = 0;
        q2dot(i) = jmax*t1;
        qdot(i) = 1/2*jmax*t1^2 + jmax*t1*(t(i) - t1);
        q(i) = 1/6*jmax*t1^3 + 1/2*jmax*t1^2*(t(i) - t1) + 1/2*jmax*t1*(t(i) - t1)^2;
    elseif t(i) < t3
        j(i) = -jmax;
        q2dot(i) = jmax*t1 - jmax*(t(i)-t2);
        qdot(i) = 1/2*jmax*t1^2 + jmax*t1*ta_m + jmax*t1*(t(i)-t2) - 1/2*jmax*(t(i)-t2)^2;
        q(i) = 1/6*jmax*t1^3 + 1/2*jmax*ta_m*t1^2 + 1/2*jmax*ta_m^2*t1 + (1/2*jmax*t1^2 + jmax*t1*ta_m)*(t(i)-t2) + 1/2*jmax*t1*(t(i)-t2)^2 - 1/6*jmax*(t(i)-t2)^3;
    elseif t(i) < t4
        j(i) = 0;
        q2dot(i) = 0;
        qdot(i) = jmax*t1^2 + jmax*t1*ta_m;
        q(i) = jmax*t1^3 + 3/2*jmax*ta_m*t1^2 + 1/2*jmax*ta_m^2*t1 + (jmax*t1^2 + jmax*t1*ta_m)*(t(i)-t3);
    elseif t(i) < t5
        q4 = jmax*t1^3 + 3/2*jmax*ta_m*t1^2 + 1/2*jmax*ta_m^2*t1 + (jmax*t1^2 + jmax*t1*ta_m)*tm;
        j(i) = -jmax;
        q2dot(i) = -jmax*(t(i)-t4);
        qdot(i) = vmax - 1/2*jmax*(t(i)-t4)^2;
        q(i) = q4 + vmax*(t(i) - t4) - 1/6*jmax*(t(i)-t4)^3;
    elseif t(i) < t6
      q2dot(i) = -jmax*tc;
        j(i) = 0;
       qdot(i) = vmax - 1/2*jmax*tc^2 - jmax*tc*(t(i)-t5);
        q(i) = q4 + vmax*tc - 1/6*jmax*tc^3 + (vmax - 1/2*jmax*tc^2)*(t(i)-t5) - 1/2*jmax*tc*(t(i)-t5)^2;
    else
        j(i) = jmax;
        q2dot(i) = -jmax*tc + jmax*(t(i)-t6);
        qdot(i) = vmax - 1/2*jmax*tc^2 - jmax*tc*ta_m -jmax*tc*(t(i)-t6) + 1/2*jmax*(t(i)-t6)^2;
        q(i) = q4 + vmax*tc - 1/6*jmax*tc^3 + (vmax - 1/2*jmax*tc^2)*ta_m - 1/2*jmax*tc*ta_m^2 + (vmax - 1/2*jmax*tc^2 - jmax*tc*ta_m)*(t(i)-t6) - 1/2*jmax*tc*(t(i)-t6)^2 + 1/6*jmax*(t(i)-t6)^3;
    end
end


end