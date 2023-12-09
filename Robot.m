    classdef Robot
    %ROBOT Summary of this class goes here
    %   Detailed explanation goes here
    
    properties                  % cac thuoc tinh cua class
        a, alpha, d, theta      % bang DH 
        type, base, n           % type cua khop, base vi tri co so, n so luong 
        x, DH,  EndEffector      % x la mang chua toa do 3D (x, y, z) cac diem cua khop
                                % T ma tran DH 
                                %  EndEffector la mang [x, y, z, roll, pitch, yaw]
                           

    end
    
    methods
        function obj = Robot(a, alpha, d, theta, type, base)  % constructors
            %ROBOT Construct an instance of this class
            %   Detailed explanation goes here
            obj.a = a;
            obj.alpha = deg2rad(alpha);
            obj.d = d;
            obj.theta = deg2rad(theta);
            obj.type = type;
            obj.base = base;
            obj.n = length(d);        
        end
        

        function obj = set_joint_variable(obj, index, q)    
            if obj.type(index) == 'r'
                obj.theta(index) = q;   % neu rotation thi theta la bien 
            elseif obj.type(index) == 'p'
                obj.d(index) = -q;       % neu translation thi d la bien 
                
            end
        end
        
        
        function obj = update(obj)
            obj.DH = Forward_Kinematics(obj.n, obj.a, obj.alpha, obj.d, obj.theta);
            for i = 1:obj.n+1
                obj.x(:,i) = (obj.DH(1:3,4,i)) + obj.base;
            end
            obj. EndEffector = [obj.x(:,obj.n+1); (obj.theta(1)+obj.theta(2) + obj.theta(4))'];
        end


        function plot_frame(obj, axes)
            Link = [0; 0; 1.865]; 
            Link = [obj.x(:, 1), Link, obj.x(:, 2:end)]; % chen them khop giua base va khop 1
            plot3(axes, Link(1,:), Link(2,:), Link(3,:), '-o', 'LineWidth', 4);
            
        end
        
        function plot_coords(obj, axes)
            vx = zeros(3, obj.n+1);
            vy = zeros(3, obj.n+1);
            vz = zeros(3, obj.n+1);
            for i = 1:obj.n+1
                vx(:,i) = obj.DH(1:3,1:3,i)*[1; 0; 0];
                vy(:,i) = obj.DH(1:3,1:3,i)*[0; 1; 0];
                vz(:,i) = obj.DH(1:3,1:3,i)*[0; 0; 1];
            end
            vx(:,obj.n) = [0, 0, 0];
            vy(:,obj.n) = [0, 0, 0];
            vz(:,obj.n) = [0, 0, 0];
            
            % Plot ref frame of each joint
            axis_scale = 1/2;
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vx(1,:), vx(2,:), vx(3,:), axis_scale, 'r', 'LineWidth', 2);
            text(obj.x(1,:)+2*axis_scale*vx(1,:), obj.x(2,:)+2*axis_scale*vx(2,:), obj.x(3,:)+2*axis_scale*vx(3,:), 'x', 'Color', 'r');
            
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vy(1,:), vy(2,:), vy(3,:), axis_scale, 'g', 'LineWidth', 2);
            text(obj.x(1,:)+2*axis_scale*vy(1,:), obj.x(2,:)+2*axis_scale*vy(2,:), obj.x(3,:)+2*axis_scale*vy(3,:), 'y', 'Color', 'g');
            
            quiver3(axes, obj.x(1,:), obj.x(2,:), obj.x(3,:), vz(1,:), vz(2,:), vz(3,:), axis_scale, 'b', 'LineWidth', 2);
            text(obj.x(1,:)+2*axis_scale*vz(1,:), obj.x(2,:)+2*axis_scale*vz(2,:), obj.x(3,:)+2*axis_scale*vz(3,:), 'z', 'Color', 'b');

        end
        
        function plot_arm(obj, axes)
            % Parameters
            COLOR_RED = [1, 0.3, 0.3];
            COLOR_GREEN = [0.3, 1, 0.3];
            COLOR_BLUE = [0.3, 0.3, 1];
            COLOR_SKYBLUE = [0.3, 0.7, 1];
            COLOR_DARKBLUE = [0, 0, 0.5];
            opacity = 0.7;
            
            % thong so kich thuoc robot
            W2 = 88/100;
            R1 = 60/100;
            L1 = 180/100;  

            R2 = W2/2;
            H2 = 24/100;
            H1 = obj.d(1) - H2;
            L2 = obj.a(1);
            H3 = 24/100;
            L3 = obj.a(2);
            

            th = linspace(0, 2*pi, 100);
            Z1 = ones(1,size(th,2))*obj.x(3,3);
            Z2 = ones(1,size(th,2))*(obj.x(3,3)-0.745);
            X = 0.3*cos(th) + obj.x(1,3);
            Y = 0.3*sin(th) + obj.x(2,3);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_GREEN, 'EdgeColor', 'none', 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z1, COLOR_GREEN, 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z2, COLOR_GREEN, 'FaceAlpha', opacity);   

            % Link 1

            X = obj.x(1,1) + 50/100;
            Y = obj.x(2,1);
            Z1 = obj.x(3,1);
            Z2 = obj.x(3,1) + H1;
            yaw = pi;
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L1*cos(yaw)+W2/2*sin(yaw), X+L1*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L1*sin(yaw)-W2/2*cos(yaw), Y+L1*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], COLOR_RED, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L1*cos(yaw)+W2/2*sin(yaw), X+L1*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L1*sin(yaw)-W2/2*cos(yaw), Y+L1*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], COLOR_RED, 'FaceAlpha', opacity)
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L1*cos(yaw), X+W2/2*sin(yaw)+L1*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L1*sin(yaw)-W2/2*cos(yaw), Y+L1*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_RED, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L1*cos(yaw), X-W2/2*sin(yaw)+L1*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L1*sin(yaw)+W2/2*cos(yaw), Y+L1*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_RED, 'FaceAlpha', opacity)
      
            
            % Link 2
            X = 0;
            Y = 0;
            Z1 = 1.8650 - H2;
            Z2 = 1.8650;
            yaw = obj.theta(1);
            
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L2*cos(yaw)+W2/2*sin(yaw), X+L2*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], COLOR_SKYBLUE, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L2*cos(yaw)+W2/2*sin(yaw), X+L2*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], COLOR_SKYBLUE, 'FaceAlpha', opacity)
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L2*cos(yaw), X+W2/2*sin(yaw)+L2*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y+L2*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_SKYBLUE, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L2*cos(yaw), X-W2/2*sin(yaw)+L2*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw), Y+L2*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_SKYBLUE, 'FaceAlpha', opacity)
            
            th = linspace(pi+yaw-pi/2, 2*pi+yaw-pi/2, 100);
            X = R2*cos(th) + 0;
            Y = R2*sin(th) + 0;
            Z1 = ones(1,size(th,2))*(obj.x(3,2) - H2);
            Z2 = ones(1,size(th,2))*obj.x(3,2);
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_SKYBLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_SKYBLUE, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_SKYBLUE, 'FaceAlpha', opacity);
            
            th = linspace(0+yaw-pi/2, pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,2);
            Y = R2*sin(th) + obj.x(2,2);
            
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_SKYBLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity)
            fill3(axes, X, Y, Z1, COLOR_SKYBLUE, 'FaceAlpha', opacity);
            fill3(axes, X, Y, Z2, COLOR_SKYBLUE, 'FaceAlpha', opacity);
            


            % Link 3
            X = obj.x(1,2);
            Y = obj.x(2,2);
            Z1 = obj.x(3,2);
            Z2 = obj.x(3,2) + H3;
            yaw = (obj.theta(1)+obj.theta(2));
            
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L3*cos(yaw)+W2/2*sin(yaw), X+L3*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw)], [Z1, Z1, Z1, Z1], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X+W2/2*sin(yaw), X+L3*cos(yaw)+W2/2*sin(yaw), X+L3*cos(yaw)-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw)], [Z2, Z2, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X+W2/2*sin(yaw), X+W2/2*sin(yaw)+L3*cos(yaw), X+W2/2*sin(yaw)+L3*cos(yaw), X+W2/2*sin(yaw)], [Y-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y+L3*sin(yaw)-W2/2*cos(yaw), Y-W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            fill3(axes, [X-W2/2*sin(yaw), X-W2/2*sin(yaw)+L3*cos(yaw), X-W2/2*sin(yaw)+L3*cos(yaw), X-W2/2*sin(yaw)], [Y+W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw), Y+L3*sin(yaw)+W2/2*cos(yaw), Y+W2/2*cos(yaw)], [Z1, Z1, Z2, Z2], COLOR_BLUE, 'FaceAlpha', opacity)
            
            th = linspace(pi+yaw-pi/2, 2*pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,2);
            Y = R2*sin(th) + obj.x(2,2);
            Z1 = ones(1,size(th,2))*obj.x(3,3);
            Z2 = ones(1,size(th,2))*(obj.x(3,3) + H3);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z1, COLOR_BLUE, 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z2, COLOR_BLUE, 'FaceAlpha', opacity);
            
            th = linspace(0+yaw-pi/2, pi+yaw-pi/2, 100);
            X = R2*cos(th) + obj.x(1,3);
            Y = R2*sin(th) + obj.x(2,3);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z1, COLOR_BLUE, 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z2, COLOR_BLUE, 'FaceAlpha', opacity);


            th = linspace(0, 2*pi, 100);
            Z1 = ones(1,size(th,2))*(obj.x(3,3) -0.745);
            Z2 = ones(1,size(th,2))*(obj.x(3,5));
            X = 0.15*cos(th) + obj.x(1,3);
            Y = 0.15*sin(th) + obj.x(2,3);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_DARKBLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z1, COLOR_DARKBLUE, 'FaceAlpha', opacity);
            fill3(axes, X , Y , Z2, COLOR_DARKBLUE, 'FaceAlpha', opacity);



            
            Z1 = ones(1,size(th,2))*(obj.x(3,5));
            Z2 = ones(1,size(th,2))*(obj.x(3,5)-0.3);
            X = 0.05*cos(th) + obj.x(1,3);
            Y = 0.05*sin(th) + obj.x(2,3);
            yaw = (obj.theta(1)+obj.theta(2) + obj.theta(4));
            Xa = [X+1/4*sin(yaw); X+1/4*sin(yaw); X-1/4*sin(yaw); X-1/4*sin(yaw)];
            Ya = [Y-1/4*cos(yaw); Y-1/4*cos(yaw); Y+1/4*cos(yaw); Y+1/4*cos(yaw)];
            Za = [Z2; Z1; Z1; Z2];
            plot3(axes, Xa , Ya, Za, 'LineWidth',1, 'Color',[0.1,0.1,0.9]);





%             th = linspace(0+yaw-pi/8-pi/2, yaw +pi/8-pi/2, 100);
%             X1 = R2*cos(th) + obj.x(1,3);
%             Y1 = R2*sin(th)  + obj.x(2,3);
%             surf(axes, [X1;X1], [Y1;Y1], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
%             fill3(axes, X1 , Y1 , Z1, COLOR_BLUE, 'FaceAlpha', opacity);
% %             fill3(axes, X , Y , Z2, COLOR_BLUE, 'FaceAlpha', opacity);
%             th = linspace(0+yaw-pi/8+pi/2, yaw +pi/8+pi/2, 100);
%             X2 = R2*cos(th) + obj.x(1,3);
%             Y2 = R2*sin(th) + obj.x(2,3);
%             surf(axes, [X2;X2], [Y2;Y2], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', opacity);
%             fill3(axes, X2 , Y2 , Z1, COLOR_BLUE, 'FaceAlpha', opacity);
%             
        end
        
        function plot_workspace(obj, axes)
            PURPLE_COLOR = [0.4940 0.1840 0.5560];
            COLOR_BLUE  = [0.1, 0.1, 0.9];

            th = deg2rad(linspace(-125, 125, 100));
            X = (obj.a(1) + obj.a(2))*cos(th);
            Y = (obj.a(1) + obj.a(2))*sin(th);
            Z1 = ones(1, size(th, 2))*(obj.d(1)-74.5/100-160/100);
            Z2 = ones(1, size(th, 2))*(obj.d(1)-74.5/100);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', PURPLE_COLOR, 'EdgeColor', 'none', 'FaceAlpha', 0.3);
            R =    sqrt(obj.a(1)^2 + obj.a(2)^2 - 2*obj.a(1)*obj.a(2)*cosd(180-145));
            
            th = deg2rad(linspace(-125, -182, 100));
            X = -obj.a(1)*cos(55*pi/180) + obj.a(2)*cos(th);
            Y = -obj.a(1)*sin(55*pi/180) + obj.a(2)*sin(th);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', 0.3);

            X = linspace(R*cos(111.407*pi/180), -obj.a(1)*cos(55*pi/180) + obj.a(2)*cos(pi), 100); 
            Y = -0.95;
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', 0.3);

            
            th = deg2rad(linspace(125, 182, 100));
            X = -obj.a(1)*cos(55*pi/180) + obj.a(2)*cos(th);
            Y = obj.a(1)*sin(55*pi/180) + obj.a(2)*sin(th);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', 0.3);
            
            th = deg2rad(linspace(-111.407, 111.407, 100));
            X = R*cos(th);
            Y = R*sin(th);
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', 0.3);
     
            X = linspace(R*cos(111.407*pi/180), -obj.a(1)*cos(55*pi/180) + obj.a(2)*cos(pi), 100); 
            Y = 0.95;
            surf(axes, [X;X], [Y;Y], [Z1;Z2], 'FaceColor', COLOR_BLUE, 'EdgeColor', 'none', 'FaceAlpha', 0.3);

        end
        

        function plot(obj, axes, coords, workspace)
            cla(axes)
            hold on;
            rotate3d(axes, 'on');
            xlabel(axes, 'x');
            ylabel(axes, 'y');
            zlabel(axes, 'z');
            xlim(axes, [obj.base(1)-4 obj.base(1)+4]);
            ylim(axes, [obj.base(2)-4 obj.base(2)+4]);
            zlim(axes, [obj.base(3)-1   obj.base(3)+3]);
            obj.plot_frame(axes);

%             view(150,30);
            if coords
                obj.plot_coords(axes);
            end
            if workspace
                obj.plot_workspace(axes);
            end            
            obj.plot_arm(axes);
%             view(axes, 33, 33);
            grid on
            drawnow;
        end    
    end
end

