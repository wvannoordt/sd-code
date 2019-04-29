function [sim_value, exp_value] = Interp2(t, alldata)
d_time = alldata(:,1); 
d_sim = alldata(:,2); 
d_exp = alldata(:,3); 
timeindex = sum(d_time <= t);
if timeindex == 0
   sim_value = d_sim(1);
   exp_value = d_exp(1);
elseif timeindex == length(d_time)
   sim_value = d_sim(end);
   exp_value = d_exp(end);  
else
    m_exp = (d_exp(timeindex+1) - d_exp(timeindex)) / (d_time(timeindex + 1) - d_time(timeindex));
    exp_value = d_exp(timeindex) + m_exp*(t - d_time(timeindex));
    m_sim = (d_sim(timeindex+1) - d_sim(timeindex)) / (d_time(timeindex + 1) - d_time(timeindex));
    sim_value = d_sim(timeindex) + m_sim*(t - d_time(timeindex));
end
end

