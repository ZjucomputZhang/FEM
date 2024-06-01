% calculate stiffness matrix.
function K_e = Ke_calc(Ae, E, v, t)

%calculate stiffness matrix unit.
%guass integration: transfer integration to sum.
%sample value's weight = 1.
x1 = 0.577350269189626;
x2 = -0.577350269189626;
Simga_in = zeros(4,1);
Theta_in = zeros(4,1);
Simga_in(1) = x2;
Simga_in(2) = x1;
Simga_in(3) = x1;
Simga_in(4) = x2;
Theta_in(1) = x2;
Theta_in(2) = x2;
Theta_in(3) = x1;
Theta_in(4) = x1;
K_e = zeros(8,8);
D = D_calc(E, v);
for i = 1:4
    [B,J] = B_calc(Ae ,Simga_in(i), Theta_in(i));
    K_e = t*J*(K_e + B'*D*B);
end

end
