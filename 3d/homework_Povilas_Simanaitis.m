function Povilas_Simanaitis_Individual_work41

% Rotating polygon moves in the square.
%  If the polygon hits the side of the square, it deforms and changes the direction of motion

    prepareScene();
    [x, y] = polygon(2);
    animate(x, y);
    clc,close all;
end

function prepareScene
    grid on;
    hold on;
    axis equal;
    axis([-10 10 -10 10 ]);
    rectangle('Position',[-8,-8,16,16],'LineWidth',3, 'EdgeColor','b');
end

function [x, y] = polygon(radius)
    da=radius*pi/20;
    ang=0:da:2*pi-da;
    x=2*sin(ang);
    y=2*cos(ang);
end

function animate(xpp, ypp)
   h1=[];
   h2=[];
   for t=0:0.1:60   
     [x, y] = calculaNewCircle(xpp, ypp, sin(t/6)*6, sin(t/6)*6, t);  
     [h1, h2] = reDrawCircle(h1,h2, x, y);
     pause(0.01); 
   end
end

function [x, y] = calculaNewCircle(x, y, dx, dy, t)
    [x, y] = transform(x,y, shift(dx, dy));
    [x, y] = transform(x,y, rotate(dx, dy, t*4));
    if(t > 10.75 && t < 13 || t > 47.75 && t < 50 ) 
        [x, y] = transform(x,y,scale(dx, dy, 0.185));
    end
    if ( t > 28.5 && t < 30.5 )
         [x, y] = transform(x,y,scale(dx, dy, -0.185));
    end  
end

function [h1, h2] = reDrawCircle(h1,h2, newX, newY)
    if ~isempty(h1), delete(h1);end  
    if ~isempty(h2), delete(h2);end
    [h1, h2] = drawCircle(newX, newY);
end

function [h1, h2] = drawCircle(xpp, ypp)
    h1=fill(xpp(1:11),ypp(1:11),'m');
    h2=fill(xpp([11:end,1]),ypp([11:end,1]),'b');
end

function [newX, newY] = transform(x,y,T)
    t = ones(1, length(x));
    A1=T*[x;y;t];
    newX=A1(1,:);
    newY=A1(2,:);
end

function T = shift(tx, ty)
    T = [1 0 tx;
         0 1 ty;
         0 0 1];
end

function T = rotate(tx, ty, d)
    betag=30*d;
    beta=betag*pi/180;
    T1=[1 0 -tx; 0 1 -ty; 0 0 1];
    T2=[cos(beta), -sin(beta), 0;sin(beta) cos(beta) 0; 0 0 1];
    T3=[1 0 tx; 0 1 ty; 0 0  1];
    T=T3*T2*T1;
end

function T = scale(px, py, s)
    sx = px * s;
    sy = py * s;
    T=[sx  0  px*(1-sx);
        0 sy  py*(1-sy); 
        0  0  1  ];
end
