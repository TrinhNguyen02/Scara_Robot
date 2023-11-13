function drawRB(T1, T2, D3, T4)
% 
% syms a alpha th d
% syms d3 th1 th2 th4


a1 = 125/10, a2 = 175/10, d1 = 162.5/10 , d4 = 0

th1 = 0 
th2 = 0 
th4 = 0
d3 = 0
% create Link using this code: 
% L = Link([Th d a alpha])
s(1) = Link([th1 d1 a1 0 0] )
s(1).qlim=[-125*pi/180 125*pi/180]
s(2) = Link([th2 0 a2 pi 0])
s(2).qlim=[-145*pi/180 145*pi/180]
s(3) = Link([0 d3 0 0 1])
s(3).qlim=[0 16]
s(4) = Link([th4 d4 0 0 0])
s(4).qlim=[-360*pi/180 360*pi/180]
Rob = SerialLink(s)

Rob.plot([0 0 0 0],'workspace', [-50 50 -50 50 -10 50]) ;
Rob.name = "my robot"

% for t = 0: 0.05 : pi
%     plot(Rob, [0 0 20 0]);
% end

for th1=0:(sign(T1)*0.1):T1
    Rob.plot([th1 0 0 0],'workspace', [-50 50 -50 50 -50 50]) 
    drawnow
end
    Rob.plot([T1 0 0 0],'workspace', [-50 50 -50 50 -50 50]) 

for th2=0:(sign(T2)*0.1):T2
    Rob.plot([T1 th2 0 0],'workspace', [-50 50 -50 50 -50 50]) 
    drawnow
end
    Rob.plot([T1 T2 0 0],'workspace', [-50 50 -50 50 -50 50]) 

for d3_=0:1:D3
    Rob.plot([T1 T2 d3_ 0],'workspace', [-50 50 -50 50 -50 50]) 
    drawnow
end 
    Rob.plot([T1 T2 D3 0],'workspace', [-50 50 -50 50 -50 50]) 

for th4=0:(sign(T4)*0.1):T4
    Rob.plot([T1 T2 D3 th4],'workspace', [-50 50 -50 50 -50 50]) 
    drawnow
end
    Rob.plot([T1 T2 D3 T4],'workspace', [-50 50 -50 50 -50 50]) 


position = Rob.getpos();
disp(position);
end


