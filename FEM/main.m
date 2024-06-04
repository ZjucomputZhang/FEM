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
x_i = 1:0.05:5;
y = 1:0.05:2;
mode = 2;
%generate
[ele, A_e, nodes_num] = Param_Gen(x_i, y, mode);
len = length(ele(:, 1));
%force distribution
if rem(length(x_i)-1 , 2) == 0
    middle_ele = (length(x_i)-1)/2;
else
    middle_ele = length(x_i)/2;
end
P_e = zeros(8, len);
%---mode == 1 ---%
% P_e(6, len) = -power(10,7);
% P_e(4, length(x_i)-1) = -power(10,8);
%----------------%

%---mode == 2 ---%
% P_e(6, len - middle_ele) = -power(10,8);
% P_e(4,length(x_i)-1) =  2*power(10,7);
P_e(5, len) = -power(10,8);
P_e(3, length(x_i)-1) = -power(10,8);
%----------------%
%coefficient
E = 210;
v = 0.3;
%thickness 
t = 0.03;
%position constrain
%<mode 1> 4 boundary nodes: 1...nodes_num/2...nodes_num/2+1...nodes_num 
%<mode 2> 4 boundary nodes: 1...length(x_i)-1...nodes_num...nodes_num - length(x_i) + 1
position_constrain = [1 nodes_num - length(x_i) + 1]';

%----main-------%

%calculate A_t
A_t = zeros(2*nodes_num, 1);
for i = 1:len
    for j = 2: 5
        A_t(2*ele(i, j) - 1,1) = A_e(2*(j -1)-1, i);
        A_t(2*ele(i, j), 1) = A_e(2*(j-1), i);
    end
end
%calculate K
K = K_assemble(ele, nodes_num, A_e, E, v, t, position_constrain);
%calculate P
P = P_calc(ele, nodes_num, P_e, position_constrain, K, A_t);
%calculate position
u = K\P;
A_t_ = A_t + u;
%output
if beam_plot(A_t, A_t_, x_i, y, nodes_num, mode) == 1
    return 
end







