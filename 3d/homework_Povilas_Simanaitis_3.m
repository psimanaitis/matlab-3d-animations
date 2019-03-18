% An object rotates about vertical axis and rotates(expands) until doubles. 
% Then the object turns over (color of an object is changed after the turnover) 
% Ten it changes the rotation direction and shrinks until it retrieves the initial size.
% Draw a ‘fisheye’ projection on the screen from a given (fixed) point.
function Povilas_Simanaitis_Individual_work43
    prepareScene3();
    [X,Y,Z] = getObject();
    object = surf(X,Y,Z,'EdgeColor','y','FaceColor','r','FaceAlpha',0.6);
    
    for t=1:1:100
      [nX,nY,nZ] = transform(X,Y,Z,scale(1+(t/100)));
      [nX,nY,nZ] = transform(nX,nY,nZ,rotate(t*3));
      delete(object);
      object = surf(nX,nY,nZ,'EdgeColor','y','FaceColor','r','FaceAlpha',0.6);
      pause(0.02); 
    end  
    
    for t=1:1:100
      [nX,nY,nZ] = transform(nX,nY,nZ,rotateVertical(1/100*pi));
      delete(object);
      object = surf(nX,nY,nZ,'EdgeColor','y','FaceColor','r','FaceAlpha',0.6);
      pause(0.02); 
    end  
    
    [X,Y,Z] = transform(X,Y,Z,rotateVertical(pi));
    for t=1:1:100
       [nX,nY,nZ] = transform(X,Y,Z,scale(2-(t/100)));
       [nX,nY,nZ] = transform(nX,nY,nZ,rotate(-t));
      delete(object);
      object = surf(nX,nY,nZ,'EdgeColor','b','FaceColor','r','FaceAlpha',0.6);
      pause(0.02); 
    end  
end

function [X,Y,Z] = transform(X,Y,Z,T)
   XYZ=[reshape(X,1,prod(size(X))); % visu rato tasku homogeniniu koordinaciu masyvas 
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