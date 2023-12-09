function [t, p, pdot, p2dot] = Linear_Interpolation(pC, pN, t, q, qdot, q2dot)
        qMax = sqrt((pN(1) - pC(1))^2 + (pN(2) - pC(2))^2 + (pN(3) - pC(3))^2);

        p = zeros(4, length(t));
        pdot = zeros(4, length(t));
        p2dot = zeros(4, length(t));

%         qi      pi - pC                 qi*(pN - pC)
%         --  =  --------        ==> pi = ------------- + pC
%         qMax    pN - pC                     qMax

%       p(4,) va p(5,) khong thay doi khong can tinh vi roll pitch khong
%       tinh


        for i = 1:length(t)
            p(1,i) = pC(1) + q(i)*(pN(1) - pC(1))/qMax;
            p(2,i) = pC(2) + q(i)*(pN(2) - pC(2))/qMax;
            p(3,i) = pC(3) + q(i)*(pN(3) - pC(3))/qMax;
            p(4,i) = pC(4) + q(i)*(pN(4) - pC(4))/qMax;
            
            pdot(1,i) = qdot(i)*(pN(1) - pC(1))/qMax;
            pdot(2,i) = qdot(i)*(pN(2) - pC(2))/qMax;
            pdot(3,i) = qdot(i)*(pN(3) - pC(3))/qMax;
            pdot(4,i) = qdot(i)*(pN(4) - pC(4))/qMax;
            
            p2dot(1,i) = q2dot(i)*(pN(1) - pC(1))/qMax;
            p2dot(2,i) = q2dot(i)*(pN(2) - pC(2))/qMax;
            p2dot(3,i) = q2dot(i)*(pN(3) - pC(3))/qMax;
            p2dot(4,i) = q2dot(i)*(pN(4) - pC(4))/qMax;
        end
    end

