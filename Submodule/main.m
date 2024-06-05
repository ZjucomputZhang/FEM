%FEM calculator entry:
%please input:
%nodes_num : total num of nodes
%ele: matrix of element's index in ele(:,1), of node's index in ele(:,2) to
%ele(:,5). element's unit number x 4
%A_e: matrix of nodes's coordinates in the element. 8x element's num
%P_e: matrix of node's given forces in the element. 8x elemnet's num
%E: coefficient of restitution GPa
%v:possion proportion
%position_constrain：index of node which is position constrained

%input:
x_i = 1:0.01:5;
y = 1.0;
mode = 1;
%generate
[ele, A_e, nodes_num] = Param_Gen(x_i, y, mode);
len = length(ele(:, 1));
%force distribution
if rem(len, 2) == 0
    middle_ele = len/2;
else
    middle_ele = (len + 1)/2;
end
P_e = zeros(8, len);
P_e(6,len) = -power(10,0);
% P_e(4,len) = power(10,8);
%coefficient
E = 210;
v = 0.3;
%thickness 
t = 0.025;
%position constrain
%nodes_num/2 nodes_num/2+1
position_constrain = [1  nodes_num]';

%----main-------%

%calculate A_t
A_t = zeros(2*nodes_num, 1);
for i = 1:len
    for j = 2: 5
        A_t(2*ele(i, j) - 1,1) = A_e(2*(j -1)-1, i);
        A_t(2*ele(i, j), 1) = A_e(2*(j-1), i);
    end
end
%initial position:
x = zeros(nodes_num,1);
y = zeros(nodes_num,1);
for i = 1:2:length(A_t)
    x((i + 1)/2) = A_t(i);
end
for i = 2:2:length(A_t)
    y(i/2) = A_t(i);
end
%calculate K
K = K_assemble(ele, nodes_num, A_e, E, v, t, position_constrain);
%calculate P
P = P_calc(ele, nodes_num, P_e, position_constrain, K, A_t);
%calculate position
% u = bslashtx(K, P);
u = K\P;
A_t = A_t + u;
%output
x_ = zeros(nodes_num,1);
y_ = zeros(nodes_num,1);
for i = 1:2:length(A_t)
    x_((i + 1)/2) = A_t(i);
end
for i = 2:2:length(A_t)
    y_(i/2) = A_t(i);
end
plot(x, y, '-',  x_, y_, '-')
axis([-5 10 -8.0 8.0]);


%---------------应力云图------------------

node=[1 0 0;
      2 1/3 0;
      3 2/3 0;
      4 1 0;
      5 1 1;
      6 2/3 1;
      7 1/3 1;
      8 0 1];   %节点信息，第一列为节点编号，2~4列分别为x,y,z方向坐标
ele=[1 1 2 7 8;
     2 2 3 6 7;
     3 3 4 5 6];        %单元信息，第一列为单元编号，后面各列为单元上的节点号码
dof=length(node(:,1))*2;       %自由度数，梁单元每个节点有2个自由度，x,y方向位移
f=ones(dof,1)*1e8;             %结构整体外载荷矩阵，整体坐标系下
f_loc=zeros(16,1);              %单元外载荷矩阵，局部坐标系下
u=ones(dof,1)*1e6;             %位移矩阵
K=zeros(dof);                  %总体刚度矩阵
n_ele=length(ele(:,1));   %单元数

for i=1:n_ele
    k_ele=RectangleElementStiffness(E,v,t,node(ele(i,2:5),2:3),1);
    K=assemRectangle(K,k_ele,ele(i,2:5));
end

%力边界条件
f(3)=0; 
f(4)=0;        
f(5)=0;     
f(6)=0;         
f(9)=0;
f(10)=0;         
f(11)=0;         
f(12)=-power(10,0);
f(13)=0;         
f(14)=0;
f(15)=0;          
f(16)=0;


%位移边界条件
u(1)=0;
u(2)=0;
u(7)=0;
u(8)=0;

%求解未知自由度
index=[];      %未知自由度的索引
p=[];          %未知自由度对应的节点力矩阵
for i=1:dof
    if u(i)~=0
        index=[index,i];
        p=[p;f(i)];
    end
end
u(index)=K(index,index)\p;    %高斯消去
f=K*u;
%单元应力
num_ele=size(ele,1);        %单元数
stress=zeros(num_ele,3);    %应力存储矩阵
x1=node(:,2)+u(1:2:16);     %变形后坐标
y1=node(:,3)+u(2:2:16);
figure;
for i=1:n_ele
    u1=[u(2*ele(i,2)-1);u(2*ele(i,2));u(2*ele(i,3)-1);u(2*ele(i,3));u(2*ele(i,4)-1);u(2*ele(i,4));u(2*ele(i,5)-1);u(2*ele(i,5))];
    stress(i,:)=RectangleElementStress(E,v,node(ele(i,2:5),2:3),u1,1)';   %单元应力计算
    patch(node(ele(i,2:5),2),node(ele(i,2:5),3),stress(i,2));     %y方向应力云图
    title('y方向应力云图')
end
hold on;
figure;
for i=1:n_ele    %变形云图
    subplot(1,2,1);
    patch(node(ele(i,2:5),2),node(ele(i,2:5),3),'w','FaceColor','none','LineStyle','-','EdgeColor','b');
    title('变形前')
    hold on;
    subplot(1,2,2);
    patch(x1(ele(i,2:5)),y1(ele(i,2:5)),'w','FaceColor','none','EdgeColor','r');
    title('变形后')
end