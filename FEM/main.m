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
x_i = 1:0.1:5;
y = 0.5;
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
P_e(6,middle_ele) = power(10,6);
% P_e(3,len) = power(10,5);
%coefficient
E = 210;
v = 0.28;
%thickness 
t = 0.01;
%position constrain
%nodes_num/2 nodes_num/2+1
position_constrain = [1 nodes_num/2 nodes_num/2+1 nodes_num]';

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
plot(x, y, '-',  x_, y_, '-');
axis([-5 10 -8.0 8.0]);



