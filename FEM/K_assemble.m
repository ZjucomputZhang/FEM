%assemble the matrix K

%@param

%ele: element's and nodes' index.
%nodes_num: total num of nodes.
%A_e: matrix of nodes' coordinates in the element. 8x4
%E: coefficient of restitution
%v:possion proportion
%t:thickness 
%A_t: matrix of nodes' coordinates
%position_constrain: martix of node's index which is position constrained
%@return 
%K: stiffness matrix

function K = K_assemble(ele, nodes_num, A_e, E, v, t, position_constrain)

len = length(ele(:, 1));

K = zeros(2*nodes_num, 2*nodes_num);

for i = 1:len
    K_e = Ke_calc(A_e(:,i), E, v, t);
    for j = 2:5
        for k =2:5 
            K((2*ele(i,j)-1):2*ele(i,j), (2*ele(i,k)-1):2*ele(i,k)) = K_e((2*(j-1)-1):2*(j-1) , (2*(k-1)-1):2*(k-1));
        end
    end
end

len = length(position_constrain);

for i = 1:len
    K(:, 2*position_constrain(i)-1) = zeros(2*nodes_num,1);
    K(2*position_constrain(i)-1, :) = zeros(1,2*nodes_num);
    K(:, 2*position_constrain(i)) = zeros(2*nodes_num,1);
    K(2*position_constrain(i), :) = zeros(1,2*nodes_num);
end
% Alpha = power(10,9);
% for i = 1:len
%     K((2*position_constrain(i)-1):2*position_constrain(i), (2*position_constrain(i)-1):2*position_constrain(i)) = Alpha*K((2*position_constrain(i)-1):2*position_constrain(i), (2*position_constrain(i)-1):2*position_constrain(i));
% end
for i = 1:len
    K((2*position_constrain(i)-1), (2*position_constrain(i)-1)) = 1;
    K(2*position_constrain(i), 2*position_constrain(i)) = 1;
end

end
