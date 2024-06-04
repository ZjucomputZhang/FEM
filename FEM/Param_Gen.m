function [ele, A_e, nodes_num] = Param_Gen(x, t, mode)
%initalize
nodes_num = 0;
eles_num = 0;

%confirm the mode
if mode == 1
%calculate the nodes' num
x_len = length(x);
nodes_num = 2*x_len;

%calculate the eles' num
if nodes_num == 4
    eles_num = 1;
elseif nodes_num > 4
    if rem(nodes_num, 2) == 0
        eles_num = (nodes_num - 4)/2 + 1;
    end   
else 
    error('ERROR');
end
%initialize in matrix ele & write eles' num in the first col
ele = zeros(eles_num, 5);
for i = 1:eles_num
    ele(i,1) = i;
end

%claculate the deltas' array
separateline_num = eles_num + 1;
delta_array = zeros(1, separateline_num);
for i = 1:separateline_num
    delta_array(i) = 2*(separateline_num+1-i)-1;
end

%generate the eles' mat
for i = 1:eles_num
    ele(i,2) = ele(i,1);
    ele(i,3) = ele(i,1)+1;
    ele(i,4) = ele(i,3) + delta_array(i+1);
    ele(i,5) = ele(i,2) + delta_array(i);
end

%generate the A_e's mat
len = length(ele(:, 1));
A_e = zeros(8,len);

for i = 1:len
    A_e(1,i) = x(i);
    A_e(2,i) = -t/2;
    A_e(3,i) = x(i+1);
    A_e(4,i) = -t/2;
    A_e(5,i) = x(i+1);
    A_e(6,i) = t/2;
    A_e(7,i) = x(i);
    A_e(8,i) = t/2;
end

end
%mesh generate
if mode == 2

x_len = length(x);
t_len = length(t);
col = x_len - 1;
raw = t_len - 1;
%calculate nodes_num
nodes_num = x_len*t_len;
%claculate eles_num
eles_num = col*raw;
ele = zeros(eles_num, 5);
%generate matrix ele
for i = 1:eles_num
    ele(i,1) = i;
    ele(i,2) = i + fix((i-1)/col);
    ele(i,3) = ele(i,2) + 1;
    ele(i,4) = ele(i,3) + x_len;
    ele(i,5) = ele(i,2) + x_len;
end
%generate element nodes' coordinate
A_e = zeros(8, eles_num);
for i = 1:eles_num
    A_e(1,i) = x(rem(i-1,col)+1);
    A_e(2,i) = t(floor((i-1)/col)+1);
    A_e(3,i) = x(rem(i-1,col)+2);
    A_e(4,i) = A_e(2,i);
    A_e(5,i) = A_e(3,i);
    A_e(6,i) = t(floor((i-1)/col)+2);
    A_e(7,i) = A_e(1,i);
    A_e(8,i) = A_e(6,i);
end

end

end
    




