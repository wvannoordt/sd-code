clear
clc
close all
for r = 0.1:0.1:0.8

theta = linspace(0.01,1.5, 100);
y = zeros(1, length(theta));
for i = 1:length(theta)
    y(i) = 0.5*P(theta(i), r);
end
theta = theta';
y = y';
plot(theta, y);
hold on;
end



xlabel('\theta');
ylabel('P(\theta)');


rs = 5;
maxqty = 100;
while maxqty > 1
   maxqty = max(pvec(theta, rs));
   rs = rs-0.01;
end
rs


function [vecout] = pvec(thetavec, r)
n = length(thetavec);
vecout = zeros(1, n);
for i = 1:n
    vecout(i) = P(thetavec(i), r);
end
end


%excruciatingly inefficient implementation.
function [tout] = P(theta, r)
theta_epsilon = 1e-4;
g = 9.81;
acc = 0;
n = 700;
thetavec = linspace(theta_epsilon, theta-theta_epsilon, n);
dtheta = thetavec(2) - thetavec(1);
for i = 1:n
    acc = acc+dtheta*(cos(thetavec(i)) - cos(theta))^(-0.5);
end
tout = 4*sqrt(r/(2*g))*acc;
end