function [asim_data] = assimilate(simdata, expdata)
exptime = 0.999*expdata(:, 1);
[n, ~] = size(simdata);
%t sim exp
asim_data = zeros(n, 3);
asim_data(:, 1) = simdata(:,1);
asim_data(:, 2) = simdata(:,2);
asim_expdata = zeros(n, 1);
for i = 1:n
    curtime = asim_data(i,1);
    timeindex = sum(exptime <= curtime);
    x1 = expdata(timeindex,2);
    x2 = expdata(timeindex + 1,2);
    t2 = exptime(timeindex + 1);
    t1 = exptime(timeindex);
    deltat =(t2 - t1);
    dt = exptime(timeindex) - curtime;
    slope = (x2 - x1)/deltat;
    value = x1 - slope*dt;
    asim_expdata(i) = value;
end
asim_data(:,3) = asim_expdata;
end

