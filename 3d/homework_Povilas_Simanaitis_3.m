% An object rotates about vertical axis and rotates(expands) until doubles. 
% Then the object turns over (color of an object is changed after the turnover) 
% Ten it changes the rotation direction and shrinks until it retrieves the initial size.
% Draw a ‘fisheye’ projection on the screen from a given (fixed) point.
function Povilas_Simanaitis_Individual_work43
    prepareScene3();
    [X,Y,Z] = getObject();
    object = surf(X,Y,Z,'EdgeColor','y','FaceColor','r','FaceAlpha',0.6);
    gif('povsim43.gif');
    for t=1:100
      [nX,nY,nZ] = transform(X,Y,Z,scale(1+(t/100)));
      [nX,nY,nZ] = transform(nX,nY,nZ,rotate(t*3));
      object = redraw(object, nX,nY,nZ, true);
    end  
    
    for t=1:100
      [nX,nY,nZ] = transform(nX,nY,nZ,rotateVertical(1/100*pi));
      object = redraw(object, nX,nY,nZ, true);
    end  
    
    [X,Y,Z] = transform(X,Y,Z,rotateVertical(pi));
    for t=1:100
       [nX,nY,nZ] = transform(X,Y,Z,scale(2-(t/100)));
       [nX,nY,nZ] = transform(nX,nY,nZ,rotate(-t));
       object = redraw(object, nX,nY,nZ, false);
    end  

    drawFishEyeProjection(nX,nY,nZ,2);
end

function object = redraw(object, nX,nY,nZ, otherColor)
    delete(object);
    if otherColor
        object = surf(nX,nY,nZ,'EdgeColor','y','FaceColor','r','FaceAlpha',0.6);
    else 
        object = surf(nX,nY,nZ,'EdgeColor','b','FaceColor','r','FaceAlpha',0.6);
    end
    gif;
    pause(0.01); 
end

function [X,Y,Z] = transform(X,Y,Z,T)
   XYZ=[reshape(X,1,prod(size(X))); 
     reshape(Y,1,prod(size(Y)));
     reshape(Z,1,prod(size(Z)));
     ones(1,prod(size(Z)))];
    A1 = T*XYZ;
    X = reshape(A1(1,:),size(X));
    Y = reshape(A1(2,:),size(Y));
    Z = reshape(A1(3,:),size(Z));
end

function T = rotate(beta)
  T=[ cos(beta) -sin(beta)  0  0;     
      sin(beta)  cos(beta)  0  0;
         0       0          1  0;
         0       0          0  1];
end

function T = rotateVertical(beta)
  T=[  cos(beta)     0   -sin(beta)   0;    
          0          1        0       0;
        sin(beta)    0    cos(beta)   0;
        0            0        0       1];
end

function T = scale(s1)    
    T=[ s1  0  0  0;
        0   s1 0  0; 
        0   0  s1 0;
        0   0  0  1];
end

function [X,Y,Z] = getObject()
    dst=pi/15;
    dst1=pi/20;
    t=[0:dst:2*pi];
    t1=[0:dst1:2*pi];
    [U,V]=meshgrid(t,t1);  
    X = U.*cos(V);
    Z = sin(U);
    Y = U.*sin(V);
end

function prepareScene3()
    clc,close all;
    h=figure(1); 
    grid on;
    hold on;
    axis equal;
    axis([-15 15 -15 15 -15 15]);
    xlabel('x');
    ylabel('y');
    zlabel('z');
    set(h,'Color','w');
    set(h,'Position',[300, 600, 500, 400]);
    view([1 -1 1]);
end

function drawFishEyeProjection(X,Y,Z,d)
    C=[-4,4,4];  
    jc=[5,4,-2];
    ic=[-1,-2,-2.5]; % must be perpendicular
    ic=ic/norm(ic);
    jc=jc/norm(jc);  
    kc=cross(ic,jc); 
    rad=6;  
    L=2*rad;
    R=[ic',jc',kc']; 
    Rinv=[R',-R'*C'; [0 0 0 1] ];
    [X,Y,Z] = transform(X,Y,Z, Rinv);
     T=[1  0  0  0;
       0  1  0  0;
       0  0  1  0; 
       0  0 1/d 0];
    [X,Y,Z] = transform(X,Y,Z, T);    
    h1=figure(2);
    grid on, hold on, axis equal,axis([-1 1 -1 1 -11 11]*L/2);
    set(h1,'Position',[900, 300, 500, 400]);
    set(h1,'Color','w');
    xlabel('x');
    ylabel('y');
    zlabel('z');
    view([180,-90]);
    surf(X,Y,Z,'EdgeColor','b','FaceColor','r','FaceAlpha',0.6);
end 