%  The expanding pyramid with differently colored walls moves down towards the cone.
%  After the contact with the cone, the cone starts to tumble down 
%  The pyramid starts rotating about the central axis of the cone
function Povilas_Simanaitis_Individual_work42
    prepareScene2();
    drawPlane();
    
    [cX,cY,cZ] = cylinder(0.25,5);
    surf(cX, cY, cZ.*12,'EdgeColor','m','FaceColor','r','FaceAlpha',0);
    
    [X,Y,Z] = getConePoints();
    cone = surf(X, Y, Z+5,'EdgeColor','B','FaceColor','r','FaceAlpha',0);
    
    [p1, p2, p3, p4] = getPyramid();
    t = -1.5;
    [np1, np2, np3, np4] = pyramidTranform(p1, p2, p3, p4, shift(-2*t-5, -2*t-5, -t));
    pyramidFigure = drawPiramid(np1,np2,np3,np4);    
    gif('povsim42.gif');
    for t=-1.5:0.04:-0.25
        [np1, np2, np3, np4] = pyramidTranform(p1, p2, p3, p4, shift(-2*t-5, -2*t-5, -t));
        delete(pyramidFigure);
        pyramidFigure = drawPiramid(np1,np2,np3,np4);
        gif;
        pause(0.02); 
    end
    
    for t=1:2:100
        delete(cone);
        cone = surf(X, Y, (Z+5)./(1+(10*t/500)),'EdgeColor','B','FaceColor','r','FaceAlpha',0);
        gif;
        pause(0.02); 
    end
    
    p1=np1; p2=np2; p3=np3; p4=np4;
    for t=1:8:1000
        [np1, np2, np3, np4] = pyramidTranform(p1, p2, p3, p4, rotate(-pi/180*t));
        delete(pyramidFigure);
        pyramidFigure = drawPiramid(np1,np2,np3,np4);
        gif;
        pause(0.02); 
    end
end

function p = drawPiramid(p1, p2, p3, p4)
     p(1) = fill3(p1(1,:), p1(2,:), p1(3,:), 'Y');
     p(2) = fill3(p2(1,:), p2(2,:), p2(3,:), 'R');
     p(3) = fill3(p3(1,:), p3(2,:), p3(3,:), 'M');
     p(4) = fill3(p4(1,:), p4(2,:), p4(3,:), 'B');
end

function [np1, np2, np3, np4] = pyramidTranform(p1, p2, p3, p4, T)
    [np1Result1, np1Result2, np1Result3] = transform(p1(1,:),p1(2,:), p1(3,:),T);
    np1 = [np1Result1; np1Result2; np1Result3];
    [np2Result1, np2Result2, np2Result3] = transform(p2(1,:),p2(2,:), p2(3,:),T);
    np2 = [np2Result1; np2Result2; np2Result3];
    [np3Result1, np3Result2, np3Result3] = transform(p3(1,:),p3(2,:), p3(3,:),T);
    np3 = [np3Result1; np3Result2; np3Result3];
    [np4Result1, np4Result2, np4Result3] = transform(p4(1,:),p4(2,:), p4(3,:),T);
    np4 = [np4Result1; np4Result2; np4Result3];
end

function [X,Y,Z] = getConePoints()
    t = -linspace(0,2*pi,40) ;
    t1 = linspace(0,2*pi,40) ;
    [U,V]=meshgrid(t,t1);  
    X = U.*cos(V);
    Y = U.*sin(V);
    Z = (U+pi).*2;
end

function [p1, p2, p3, p4] = getPyramid()
    p1 = [[7,6,5];[6,7,6];[6,9,6]];
    p2 = [[7,6,7];[6,7,8];[6,9,6]];
    p3 = [[5,6,7];[8,7,8];[6,9,6]];
    p4 = [[5,6,5];[8,7,6];[6,9,6]]; 
end

function prepareScene2()
    clc,close all;
    hf1=figure(1); 
    grid on;
    hold on;
    axis equal;
    axis([-13 13 -13 13 -13 13]);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    set(hf1,'Color','w');
    set(hf1,'Position',[300, 600, 500, 400]);
    view([1 -1 1]);
end

function T = rotate(beta)
    T=[ cos(beta)  -sin(beta) 0    0;     
        sin(beta)  cos(beta)  0    0;
           0          0       1    0;
           0          0       0    1];
end

function T = shift(toX,toY,toZ)
    T=[1 0 0 toX;
       0 1 0 toY;
       0 0 1 toZ;
       0 0 0 1];
end

function [X,Y,Z] = transform(x,y,z,T)
    t = ones(1, length(x));
    A1 = T*[x;y;z;t];
    X = A1(1,:);
    Y = A1(2,:);
    Z = A1(3,:);
end

function drawPlane()
    xx=axis; 
    fill3([xx(1),xx(1),xx(2),xx(2)],[xx(3),xx(4),xx(4),xx(3)],[1 1 1 1]*0,'g','FaceAlpha',0.2,'EdgeColor','g');
end
