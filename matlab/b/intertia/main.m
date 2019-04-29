clear
clc
close all

n_k =15;
n = 500;
ktheta_vec = linspace(0.1, 3.0, n_k);
t = linspace(0,10,n);

THETAS = zeros(n, n_k);
OMEGAS = zeros(n, n_k);
ALPHAS = zeros(n, n_k);

for j = 1:n_k

rho = 1.2;
cd = 0.8;
ktheta = ktheta_vec(j);
L = 1;
D = 0.09;
R = 0.2;
g = 9.81;
m = 0.2;
Ir = 0.0224;
Iw = 0.02;
theta0 = 0;
b = 1.2;
thetaspring = pi/2;
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

for i = 1:n_k-1
   plot(t,THETAS(:,i))
   hold on;
end
plot(t,THETAS(:,n_k))



