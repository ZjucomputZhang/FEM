%calculate matrix B
%input param vector F 8x1
function [B, J] = B_calc(F, Simga_in, Theta_in)

syms Simga Theta;

%get the coordinate:
x = zeros(4,1);
y = zeros(4,1);
for i = 1:4
    x(i) = F(2*i-1);
end
for i=1:4
    y(i) = F(2*i);
end

%calculate the transfer function
Ni = 1/4*(1 - Simga)*(1 - Theta);
Nj = 1/4*(1 + Simga)*(1 - Theta);
Nm = 1/4*(1 + Simga)*(1 + Theta);
Nn = 1/4*(1 - Simga)*(1 + Theta);

% x = Ni*F(1) + Nj*F(3) + Nm*F(5) + Nn*F(7);
% y = Ni*F(2) + Nj*F(4) + Nm*F(6) + Nn*F(8);

%calculate the coefficient
fa(Simga,Theta) = 1/4*(y(1)*(Simga-1)+y(2)*(-1-Simga)+y(3)*(1+Simga)+y(4)*(1-Simga));
fb(Simga,Theta) = 1/4*(y(1)*(Theta-1)+y(2)*(1-Theta)+y(3)*(1+Theta)+y(4)*(-1-Theta));
fc(Simga,Theta) = 1/4*(x(1)*(Theta-1)+x(2)*(1-Theta)+x(3)*(1+Theta)+x(4)*(-1-Theta));
fd(Simga,Theta) = 1/4*(x(1)*(Simga-1)+x(2)*(-1-Simga)+x(3)*(1+Simga)+x(4)*(1-Simga));
a = double(fa(Simga_in, Theta_in));
b = double(fb(Simga_in, Theta_in));
c = double(fc(Simga_in, Theta_in));
d = double(fd(Simga_in, Theta_in));
%diff the Ni
fNis(Simga,Theta) = diff(Ni, Simga);
fNit(Simga,Theta) = diff(Ni, Theta);
fNjs(Simga,Theta) = diff(Nj, Simga);
fNjt(Simga,Theta) = diff(Nj, Theta);
fNms(Simga,Theta) = diff(Nm, Simga);
fNmt(Simga,Theta) = diff(Nm, Theta);
fNns(Simga,Theta) = diff(Nn, Simga);
fNnt(Simga,Theta) = diff(Nn, Theta);

Nis = double(fNis(Simga_in, Theta_in));
Nit = double(fNit(Simga_in, Theta_in));
Njs = double(fNjs(Simga_in, Theta_in));
Njt = double(fNjt(Simga_in, Theta_in));
Nms = double(fNms(Simga_in, Theta_in));
Nmt = double(fNmt(Simga_in, Theta_in));
Nns = double(fNns(Simga_in, Theta_in));
Nnt = double(fNnt(Simga_in, Theta_in));
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
        Theta_in-1 0 Simga_in+1 -Simga_in-1;
        Simga_in-Theta_in -Simga_in-1 0 Theta_in+1;
        1-Simga_in Simga_in+1 -Theta_in-1 0;];
J = 1/8*x'*J_TR*y;
%calculate B
B = [Bi Bj Bm Bn]/J;

% syms B(Simga, Theta) [3,8]
% B1_1(Simga, Theta) = diff(Ni, Simga)*diff(x, Theta) - diff(x, Simga)*diff(Ni, Theta);
% B1_2(Simga, Theta) = 0;
% B1_3(Simga, Theta) = diff(Nj, Simga)*diff(x, Theta) - diff(x, Simga)*diff(Nj, Theta);
% B1_4(Simga, Theta) = 0;
% B1_5(Simga, Theta) = diff(Nm, Simga)*diff(x, Theta) - diff(x, Simga)*diff(Nm, Theta);
% B1_6(Simga, Theta) = 0;
% B1_7(Simga, Theta) = diff(Nn, Simga)*diff(x, Theta) - diff(x, Simga)*diff(Nn, Theta);
% B1_8(Simga, Theta) = 0;
% B2_1(Simga, Theta) = 0;
% B2_2(Simga, Theta) = diff(Ni, Simga)*diff(x, Theta) - diff(x, Simga)*diff(Ni, Theta);
% B2_3(Simga, Theta) = 0;
% B2_4(Simga, Theta) = diff(Nj, Simga)*diff(x, Theta) - diff(x, Simga)*diff(Nj, Theta);
% B2_5(Simga, Theta) = 0;
% B2_6(Simga, Theta) = diff(Nm, Simga)*diff(x, Theta) - diff(x, Simga)*diff(Nm, Theta);
% B2_7(Simga, Theta) = 0;
% B2_8(Simga, Theta) = diff(Nn, Simga)*diff(x, Theta) - diff(x, Simga)*diff(Nn, Theta);
% B3_1(Simga, Theta) = diff(Ni, Simga)*diff(x, Theta) - diff(Ni, Theta)*diff(x, Simga) + diff(y, Simga)*diff(0, Theta) - diff(y, Theta)*diff(0, Simga);
% B3_2(Simga, Theta) = diff(0, Simga)*diff(x, Theta) - diff(0, Theta)*diff(x, Simga) + diff(y, Simga)*diff(Ni, Theta) - diff(y, Theta)*diff(Ni, Simga);
% B3_3(Simga, Theta) = diff(Nj, Simga)*diff(x, Theta) - diff(Nj, Theta)*diff(x, Simga) + diff(y, Simga)*diff(0, Theta) - diff(y, Theta)*diff(0, Simga);
% B3_4(Simga, Theta) = diff(0, Simga)*diff(x, Theta) - diff(0, Theta)*diff(x, Simga) + diff(y, Simga)*diff(Nj, Theta) - diff(y, Theta)*diff(Nj, Simga);
% B3_5(Simga, Theta) = diff(Nm, Simga)*diff(x, Theta) - diff(Nm, Theta)*diff(x, Simga) + diff(y, Simga)*diff(0, Theta) - diff(y, Theta)*diff(0, Simga);
% B3_6(Simga, Theta) = diff(0, Simga)*diff(x, Theta) - diff(0, Theta)*diff(x, Simga) + diff(y, Simga)*diff(Nm, Theta) - diff(y, Theta)*diff(Nm, Simga);
% B3_7(Simga, Theta) = diff(Nn, Simga)*diff(x, Theta) - diff(Nn, Theta)*diff(x, Simga) + diff(y, Simga)*diff(0, Theta) - diff(y, Theta)*diff(0, Simga);
% B3_8(Simga, Theta) = diff(0, Simga)*diff(x, Theta) - diff(0, Theta)*diff(x, Simga) + diff(y, Simga)*diff(Nn, Theta) - diff(y, Theta)*diff(Nn, Simga);
% J = jacobian([x, y],[Simga, Theta]);
% DET(Simga, Theta) = det(J);
% tmp = DET(Simga_in, Theta_in);
% Det = double(tmp);
% B_e = zeros(3,8);
% B_e(1,1) = B1_1(Simga_in, Theta_in);
% B_e(1,2) = B1_2(Simga_in, Theta_in);
% B_e(1,3) = B1_3(Simga_in, Theta_in);
% B_e(1,4) = B1_4(Simga_in, Theta_in);
% B_e(1,5) = B1_5(Simga_in, Theta_in);
% B_e(1,6) = B1_6(Simga_in, Theta_in);
% B_e(1,7) = B1_7(Simga_in, Theta_in);
% B_e(1,8) = B1_8(Simga_in, Theta_in);
% B_e(2,1) = B2_1(Simga_in, Theta_in);
% B_e(2,2) = B2_2(Simga_in, Theta_in);
% B_e(2,3) = B2_3(Simga_in, Theta_in);
% B_e(2,4) = B2_4(Simga_in, Theta_in);
% B_e(2,5) = B2_5(Simga_in, Theta_in);
% B_e(2,6) = B2_6(Simga_in, Theta_in);
% B_e(2,7) = B2_7(Simga_in, Theta_in);
% B_e(2,8) = B2_8(Simga_in, Theta_in);
% B_e(3,1) = B3_1(Simga_in, Theta_in);
% B_e(3,2) = B3_2(Simga_in, Theta_in);
% B_e(3,3) = B3_3(Simga_in, Theta_in);
% B_e(3,4) = B3_4(Simga_in, Theta_in);
% B_e(3,5) = B3_5(Simga_in, Theta_in);
% B_e(3,6) = B3_6(Simga_in, Theta_in);
% B_e(3,7) = B3_7(Simga_in, Theta_in);
% B_e(3,8) = B3_8(Simga_in, Theta_in);
% 
% B_e = 1/Det*B_e;

% end



