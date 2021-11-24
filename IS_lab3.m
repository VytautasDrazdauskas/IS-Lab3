clc;
clear all;
close all;

%pradiniai parametrai
x = [0.1:1/22:1]; %įėjime paduodamas 20 skaičių vektorius X. 0.1:1/22:1
output_untrained = sin(2*pi*x)/2; %y = (1 + 0.6*sin(2*pi*x/0.7)) + 0.3*sin(2*pi*x))/2;

w1 = rand(1);
w2 = rand(1);
w3 = rand(1);
b = randn(1);
n = 0.1;

%centrų reikšmes c1 ir c2, spindulių reikšmes r1 ir r2 parinkite rankiniu būdu
c1 = 0.7;
c2 = 0.3;

r1 = 0.4;
r2 = 0.5;

for idx=1:100
   for i=1:20
        y = gauss(x(i),r1,c1)*w1+gauss(x(i),r2,c2)*w2+b;
        err = output_untrained(i) - y; 
        b = b + n*err;
        w1 = w1 + n*err*gauss(x(i),r1,c1);
        w2 = w2 + n*err*gauss(x(i),r2,c2);
   end
   idx = idx - 1;
end

output_trained = gauss(x,r1,c1)*w1+gauss(x,r2,c2)*w2+b;

figure(1)
plot(x,output_untrained,'b',x,output_trained,'r'); 
grid on;
hold on;
legend('Prieš treniravimą', 'Po treniravimo')
title('Skirtumas netreniruotų ir treniruotų duomenų')

%naudojamos funkcijos
function F = gauss(x,r,c)       
    F = exp(-(x-c).^2/(2*r.^2)); %dvi spindulio tipo funkcijos F = exp(-(x-c)^2/(2*r^2)).
end