clear
clc
close all

framect = 1000;
xmin = 0;
xmax = 1;
dt = 0.01;
n = 100;
x = linspace(xmin, xmax, n)';
dx = x(5) - x(4);
y = zeros(size(x));
yold = y;
velocity = zeros(size(x));
T = 1;

for i = 1:framect
   plot(y);
   
end
