clear
clc
close all

simcount = 10;
max_accel_absolute = 27.50;
dt = 0.01;
profcount = 5;
rmp = 0:profcount;
rmp = rmp/profcount;
maxratio = 2;
stallratio = 1.4;
lgth = round(length(rmp)*maxratio);
stall_lngth = round(length(rmp)*stallratio);
accel_profile_normal = [rmp ones(1, lgth) 1 - rmp];
half_profile_normal = [accel_profile_normal zeros(1, stall_lngth) -accel_profile_normal zeros(1, stall_lngth)];
full_profile_normal = [half_profile_normal -half_profile_normal];
a = full_profile_normal';
num = length(full_profile_normal);
v = zeros(num, 1);
s = zeros(num,1);
v(1) = 0;
s(1) = 0;
for i = 2:num
    v(i) = v(i-1) + a(i-1)*dt;
    s(i) = s(i-1) + v(i-1)*dt;
end

a = max_accel_absolute*a;
v = max_accel_absolute*v;
s = max_accel_absolute*s;



for k = 1:simcount
for i = 1:num
    x = [-sin(s(i)) 0 sin(s(i))]';
    y = [cos(s(i)) 0 cos(s(i))]';
    plot(x, y);
    pbaspect([1 1 1]);
    axis([-1 1 -1 1]);
    pause(dt);
end
end

