clear
clc
close all

writerObj = VideoWriter('./output_video/tracking.avi');
open(writerObj);
for K = 1 : 150
  filename = strcat('./output_frames/frm_', fnum2str(K),'.png');
  thisimage = imread(filename);
  writeVideo(writerObj, thisimage);
end
close(writerObj);