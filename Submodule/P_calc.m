function P = P_calc(ele, nodes_num, P_e, position_constrain, K, A_t)

len = length(ele(:, 1));
P = zeros(2*nodes_num, 1);

for i = 1:len
    for j = 2: 5
        P(2*ele(i, j) - 1,1) = P(2*ele(i, j) - 1,1) + P_e(2*(j -1)-1, i);
        P(2*ele(i, j), 1) = P(2*ele(i, j), 1) + P_e(2*(j-1), i);
    end
end

len = length(position_constrain);
% Alpha = power(10,9);
% for i = 1:len
%     P((2*position_constrain(i)- 1):2*position_constrain(i)) = Alpha*K((2*position_constrain(i)-1):2*position_constrain(i), (2*position_constrain(i)-1):2*position_constrain(i))*A_t((2*position_constrain(i)-1):2*position_constrain(i));
% end
for i = 1:len
    P((2*position_constrain(i)- 1)) = 0;
    P(2*position_constrain(i)) = 0;
end
end
