function D = D_calc(E,v)

k = E*power(10,9)/(1 - v*v);

temp = [1 v 0;
        v 1 0;
        0 0 (1 - v)/2];
D = k * temp;

end




