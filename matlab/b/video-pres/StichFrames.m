clear
clc
close all

%prototype for single
parfor p = 1:150
    p
plotname = strcat('./plot_frames/plot_', fnum2str(p),'.png');
imname = strcat('./vid_frames/frame_', fnum2str(p),'.png');

plotim = imread(plotname);
plotim = imresize(plotim, 1.3);
imim = imread(imname);
template = uint8(255*ones(1080, 2188, 3));
[I, J, ~] = size(imim);
for i = 1:I
   for j = 1:J
       template(i,j,:) = imim(i,j,:);
   end
end
[II, JJ, ~] = size(plotim);
for i = 1:II
   for j = 1:JJ
       template(i + 125,j + 1050,:) = plotim(i,j,:);
   end
end
imwrite(template, strcat('./output_frames/frm_', fnum2str(p),'.png'));
end