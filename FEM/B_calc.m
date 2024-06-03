%calculate matrix B
%input param vector F 8x1
function [B, J] = B_calc(F, Simga_in, Theta_in)

%get the coordinate:
x = zeros(4,1);
y = zeros(4,1);
for i = 1:4
    x(i) = F(2*i-1);
end
for i=1:4
    y(i) = F(2*i);
end
%calculate the coefficient
a = 1/4*(y(1)*(Simga_in-1)+y(2)*(-1-Simga_in)+y(3)*(1+Simga_in)+y(4)*(1-Simga_in));
b = 1/4*(y(1)*(Theta_in-1)+y(2)*(1-Theta_in)+y(3)*(1+Theta_in)+y(4)*(-1-Theta_in));
c = 1/4*(x(1)*(Theta_in-1)+x(2)*(1-Theta_in)+x(3)*(1+Theta_in)+x(4)*(-1-Theta_in));
d = 1/4*((x(1)-x(2)+x(3)-x(4))*Simga_in -x(1)-x(2)+x(3)+x(4));
%diff the Ni
Nis = 1/4*(Theta_in -1);
Nit = 1/4*(Simga_in -1);
Njs = 1/4*(1-Theta_in);
Njt = -1/4*(1+Simga_in);
Nms = 1/4*(1+Theta_in);
Nmt = 1/4*(1+Simga_in);
Nns = -1/4*(1+Theta_in);
Nnt = 1/4*(1-Simga_in);
%calculate the Bk k = i, j, m, n
Bi = [a*Nis-b*Nit 0;
      0 c*Nit-d*Nis;
      c*Nit-d*Nis a*Nis-b*Nit];
Bj = [a*Njs-b*Njt 0;
      0 c*Njt-d*Njs;
      c*Njt-d*Njs a*Njs-b*Njt];
Bm = [a*Nms-b*Nmt 0;
      0 c*Nmt-d*Nms;
      c*Nmt-d*Nms a*Nms-b*Nmt];
Bn = [a*Nns-b*Nnt 0;
      0 c*Nnt-d*Nns;
      c*Nnt-d*Nns a*Nns-b*Nnt];
%calculate the det(J)
J_TR = [0 1-Theta_in Theta_in-Simga_in Simga_in-1;
        Theta_in-1 0 Simga_in+1 -Simga_in-Theta_in;
        Simga_in-Theta_in -Simga_in-1 0 Theta_in+1;
        1-Simga_in Simga_in+Theta_in -Theta_in-1 0;];
J = 1/8*x'*J_TR*y;
%calculate B
B = [Bi Bj Bm Bn]/J;

end


