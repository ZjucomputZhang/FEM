%计算单元刚度矩阵
function k_ele=RectangleElementStiffness(E,miu,h,node_ele,p)
%TriangleElementStiffness This function returns the element
% stiffness matrix for a grid
% element with modulus of elasticity E,
% Poission's ratio miu, constant thickness h,
% node_ele the node coordinate of element，plane stress or plane strain option.
% The size of the element stiffness
% matrix is 8 x 8.
syms t s;       %定义自然坐标
%---------node coordinate------
x1=node_ele(1,1);                
y1=node_ele(1,2);
x2=node_ele(2,1);                
y2=node_ele(2,2);
x3=node_ele(3,1);                
y3=node_ele(3,2);
x4=node_ele(4,1);                
y4=node_ele(4,2);
%-------------------------------
%-------shape fuction------------
N1=((1-s)*(1-t))/4;
N2=((1+s)*(1-t))/4;
N3=((1+s)*(1+t))/4;
N4=((1-s)*(1+t))/4;
%--------------------------------------
%------- Jacobian determinant----------
xc=[x1 x2 x3 x4];
yc=[y1 y2 y3 y4];
J_m=[0 1-t t-s s-1;
     t-1 0 s+1 -s-t;
     s-t -s-1 0 t+1;
     1-s s+t -t-1 0];
J=xc*J_m*yc'/8;
%------------------------------------
%----------gradient function---------
a=(y1*(s-1)+y2*(-1-s)+y3*(1+s)+y4*(1-s))/4;
b=(y1*(t-1)+y2*(1-t)+y3*(1+t)+y4*(-1-t))/4;
c=(x1*(t-1)+x2*(1-t)+x3*(1+t)+x4*(-1-t))/4;
d=(x1*(s-1)+x2*(-1-s)+x3*(1+s)+x4*(1-s))/4;
N1s=diff(N1,s);
N1t=diff(N1,t);
N2s=diff(N2,s);
N2t=diff(N2,t);
N3s=diff(N3,s);
N3t=diff(N3,t);
N4s=diff(N4,s);
N4t=diff(N4,t);
B1=[a*N1s-b*N1t 0;
    0 c*N1t-d*N1s;
    c*N1t-d*N1s a*N1s-b*N1t];
B2=[a*N2s-b*N2t 0;
    0 c*N2t-d*N2s;
    c*N2t-d*N2s a*N2s-b*N2t];
B3=[a*N3s-b*N3t 0;
    0 c*N3t-d*N3s;
    c*N3t-d*N3s a*N3s-b*N3t];
B4=[a*N4s-b*N4t 0;
    0 c*N4t-d*N4s;
    c*N4t-d*N4s a*N4s-b*N4t];
B=[B1 B2 B3 B4]/J;
%-------------------------------------
%------strss/strain matrix-------------
if p==1
    D=E/(1-miu^2)*[1 miu 0;
                   miu 1 0;
                   0 0 (1-miu)/2];           %strss/strain matrix for plane stress
elseif p==2
    D=E/(1+miu)/(1-2*miu)*[1-miu miu 0;
                           miu 1-miu 0;
                       0 0 (1-2*miu)/2];     %strss/strain matrix for plane strain
end
BD=B'*D*B*J;
r=int(int(BD,t,-1,1),s,-1,1);
k_ele=double(h*r);    %的单元刚度矩阵
end
