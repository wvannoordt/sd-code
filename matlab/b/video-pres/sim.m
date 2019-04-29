clear
clc
close all

n_k =20;
n = 500;
ktheta_vec = [3.8 4.8 5.5];
t = linspace(0,4,n);

THETAS = zeros(n, n_k);
OMEGAS = zeros(n, n_k);
ALPHAS = zeros(n, n_k);

for j = 1:length(ktheta_vec)

%everything is SI!
rho = 1.2;
cd = 0.0;
ktheta = ktheta_vec(j);
L = 0.6;
D = 0.09;
R = 0.08;
g = 9.81;
m = 0.1;
Ir = 0.0224;
Iw = 0.085;
theta0 = 0;
b = 0.4;
thetaspring = 1.3;
omega_tol = 0.05;
omega0 = 0;


dt = t(2) - t(1);
theta = zeros(n,1);
omega = zeros(n,1);
alpha = zeros(n,1);
theta(1) = theta0;
omega(1) = omega0;
A1 = ktheta*(thetaspring - theta0) - 0.125*(rho*cd*(L^4)*omega0*abs(omega0)*D) - b*omega0 - m*g*R*sin(theta0);
B1 = Iw + Ir + m*R^2*(sin(theta0)^2);
C1 = 1 + (Ir + m*R^2*sin(theta0))/(Iw + Ir + m*R^2*sin(theta0)^2);
alpha(1) = A1/(B1*C1);
for i = 2:n
    omega(i) = omega(i-1) + alpha(i-1)*dt;
    theta(i) = theta(i-1) + omega(i-1)*dt;
    A = ktheta*(thetaspring - theta(i-1))- b*omega(i-1) - 0.125*(rho*cd*(L^4)*omega(i-1)*abs(omega(i-1))*D) - m*g*R*sin(theta(i-1));
    B = Iw + Ir + m*R^2*(sin(theta(i-1))^2);
    C = 1 + (Ir + m*R^2*sin(theta(i-1)))/(Iw + Ir + m*R^2*sin(theta(i-1))^2);
    alpha(i) = A/(B*C);
end
THETAS(:, j) = theta(:);
OMEGAS(:, j) = omega(:);
ALPHAS(:, j) = alpha(:);
end

v1 = csvread('experimental_data_clean/v1.csv');
v2 = csvread('experimental_data_clean/v2.csv');
v3 = csvread('experimental_data_clean/v3.csv');

figure
plot(t,THETAS(:,1));
hold on
plot(v1(:,1), v1(:,2));
xlabel('t', 'FontSize', 16);
ylabel('\theta', 'FontSize', 16);
title('Comparison of Experimental Data and Simulation', 'FontSize', 14);
legend('Simulation', 'Experiment');
saveas(gcf, 'images/v1.png');

figure
plot(t,THETAS(:,2));
hold on
plot(v2(:,1), v2(:,2));
xlabel('t', 'FontSize', 16);
ylabel('\theta', 'FontSize', 16);
title('Comparison of Experimental Data and Simulation', 'FontSize', 14);
legend('Simulation', 'Experiment');
saveas(gcf, 'images/v2.png');

figure
plot(t,THETAS(:,3));
hold on
plot(v3(:,1), v3(:,2));
xlabel('t', 'FontSize', 16);
ylabel('\theta', 'FontSize', 16);
title('Comparison of Experimental Data and Simulation', 'FontSize', 14);
legend('Simulation', 'Experiment');
saveas(gcf, 'images/v3.png');

%figure

%for i = 1:n_k-1
%   plot(t,OMEGAS(:,i))
%   hold on;
%end
%plot(t,OMEGAS(:,n_k))
%ylabel('\omega');
%xlabel('t');

%MAKE DATA FOR VIDEO
%t theta
datasim = [t' THETAS(:,1)];
dataexp = [v1(:,1) v1(:,2)];
dataout = assimilate(datasim, dataexp);
figure
plot(dataout(:, 1), dataout(:, 2))
hold on
plot(dataout(:, 1), dataout(:, 3))

csvwrite('./pres_data/t_exp_sim_v1.csv', dataout);


