clear
clc

%clean up data;

framerate = 29;
deltat = 1/framerate;
%         v1  v2  v3  v4  v5 <- v4, v5 = worthless data
starts = [307 75  210 1   1];
lengths =[150 85  150 1   1];

for i = 1:3
  startnum = starts(i);
  endnum = startnum + lengths(i)-1;
  data = csvread(strcat('experimental_data/v', num2str(i),'.csv'));
  cleandatav = data(startnum:endnum);
  t = 0:(length(cleandatav) - 1);
  t = deltat*t';
  totaldata_t_theta = [t cleandatav];
  csvwrite(strcat('experimental_data_clean/v', num2str(i),'.csv'), totaldata_t_theta);
end
