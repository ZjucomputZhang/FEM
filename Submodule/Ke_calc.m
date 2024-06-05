% calculate stiffness matrix.
function K_e = Ke_calc(Ae, E, v, t)

%calculate stiffness matrix unit.
%guass integration: transfer integration to sum.
%sample value's weight = 1.


x1 = 1/sqrt(3);
x2 = -x1; 
Simga_in = [x2 x1 x1 x2]';
Theta_in = [x2 x2 x1 x1]';
% gpt = sqrt(3/5);
% Simga_in = [-gpt gpt gpt -gpt 0 gpt 0 -gpt 0]';
% Theta_in = [-gpt -gpt gpt gpt -gpt 0 gpt 0 0]';
% w = [25/81 40/81 64/81];

K_e = zeros(8,8);
D = D_calc(E, v);
for i = 1:4
    [B,J] = B_calc(Ae, Simga_in(i), Theta_in(i));
    K_e = K_e + t*J*(B'*D*B);
end

% for i = 1:9
%     [B,J] = B_calc(Ae, Simga_in(i), Theta_in(i));
%     if i<=4
%     K_e = K_e + w(1)*t*J*(B'*D*B);
%     end
%     if i<=8
%     K_e = K_e + w(2)*t*J*(B'*D*B); 
%     end
%     if i == 9
%     K_e = K_e + w(3)*t*J*(B'*D*B);
%     end
% end

end
