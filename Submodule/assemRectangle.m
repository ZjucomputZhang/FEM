%刚度组装函数
function k_t=assemRectangle(k_t,k_ele,node)
%assemRectangle This function assembles the element stiffness
% matrix k of the plane Rectangle element into the global stiffness matrix K.
% This function returns the global stiffness
% matrix K after the element stiffness matrix
% k is assembled.
d(1:2)=2*node(1)-1:2*node(1);
d(3:4)=2*node(2)-1:2*node(2);
d(5:6)=2*node(3)-1:2*node(3);
d(7:8)=2*node(4)-1:2*node(4);
for ii=1:8
    for jj=1:8
        k_t(d(ii),d(jj))=k_t(d(ii),d(jj))+k_ele(ii,jj);
    end
end
end