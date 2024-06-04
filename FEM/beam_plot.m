function [state] = beam_plot(A_i, A_t, x, t, nodes_num, mode)

if mode == 1
%calculate initial coordinates
x_i = zeros(nodes_num,1);
y_i = zeros(nodes_num,1);
for i = 1:nodes_num
    x_i(i) = A_i(2*i-1);
    y_i(i) = A_i(2*i);
end
%calculate final coordinate
x_t = zeros(nodes_num,1);
y_t = zeros(nodes_num,2);
for i = 1: nodes_num
    x_t(i) = A_t(2*i-1);
    y_t(i) = A_t(2*i);
end
%output
plot(x_i, y_i, '-', x_t, y_t, '-');
axis([-5 10 -8 8]);
end

if mode == 2
x_len = length(x);
t_len = length(t);
%---standardize the coordinate---%
%generate horizon line
x_h_ = zeros(x_len, t_len);
y_h_ = zeros(x_len, t_len);
for i = 1:nodes_num
    x_h_(rem(i-1, x_len) + 1, floor((i-1)/x_len) + 1) = A_i(2*i-1);
    y_h_(rem(i-1,x_len) + 1, floor((i-1)/x_len) + 1) = A_i(2*i);
end
%generate vertical line
x_v_ = zeros(t_len, x_len);
y_v_ = zeros(t_len, x_len);
for i = 1:nodes_num
    y_v_(floor((i-1)/x_len) + 1, rem(i-1,x_len) + 1) = A_i(2*i);
    x_v_(floor((i-1)/x_len) + 1, rem(i-1,x_len) + 1) = A_i(2*i-1);
end

%---standardize the coordinate---%
%generate horizon line
x_h = zeros(x_len, t_len);
y_h = zeros(x_len, t_len);
for i = 1:nodes_num
    x_h(rem(i-1, x_len) + 1, floor((i-1)/x_len) + 1) = A_t(2*i-1);
    y_h(rem(i-1,x_len) + 1, floor((i-1)/x_len) + 1) = A_t(2*i);
end
%generate vertical line
x_v = zeros(t_len, x_len);
y_v = zeros(t_len, x_len);
for i = 1:nodes_num
    y_v(floor((i-1)/x_len) + 1, rem(i-1,x_len) + 1) = A_t(2*i);
    x_v(floor((i-1)/x_len) + 1, rem(i-1,x_len) + 1) = A_t(2*i-1);
end
subplot(1,2,1);
plot(x_h_,y_h_,'-', x_v_, y_v_, '-');
axis([-5 10 -8 8]);
subplot(1,2,2);
plot(x_h, y_h, '-', x_v, y_v, '-');
axis([-5 10 -8 8]);
end
%confirm the state
state = 1;

end
