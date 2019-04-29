clear
clc
close all

for vidnum = 1:5
path = strcat('./data/v', num2str(vidnum),'.mp4');
outputpath = strcat('./outputdata/v', num2str(vidnum), '.csv');
FrameNumber = 1;
minframe = 300;
hinge = [35, 420];
%greenproto = [108 135 92];
mov = VideoReader(path);
thisFrame = readFrame(mov);
%xmin xmax ymin ymax
THETAS = [];
figure(1)
while hasFrame(mov)
    %imshow(thisFrame);
    FrameNumber = FrameNumber + 1;
    try
    thisFrame = readFrame(mov);
    thisFrame = thisFrame(:,800:end,:);
    thisFrame = insertMarker(thisFrame,hinge, 'x', 'color', 'green');
    HSV = rgb2hsv(thisFrame);
    % "20% more" saturation:
    HSV(:, :, 2) = HSV(:, :, 2) * 10;
    HSV(HSV > 1) = 1;
    thisFramenew = hsv2rgb(HSV);
    thisFramenew = 255*thisFramenew;
    thisFramenew = uint8(thisFramenew);
    filter = thisFramenew(:,:,3) - thisFramenew(:,:,2) - thisFramenew(:,:,1);
    filterbw = filter > 50;
    filterimg1 = 255*uint8(filterbw);
    filterimgwhole = cat(3, filterimg1,filterimg1,filterimg1);
    disp = cat(2,thisFrame,filterimgwhole);
    disp = insertMarker(disp,hinge + [size(thisFrame,2),0], 'star', 'color', 'green', 'size', 25);
    stats = regionprops(filterbw);
    centroids = cat(1, stats.Centroid);
    areas = cat(1, stats.Area);
    truecentroid = [sum(areas.*centroids(:,1)), sum(areas.*centroids(:,2))]/sum(areas);
    disp = insertMarker(disp,truecentroid + [size(thisFrame,2),0], 'star', 'color', 'green', 'size', 25);
    if FrameNumber == 105
    imshow(disp);
    end
    delta = truecentroid - hinge;
    thetast = atan2(-delta(2), delta(1));
    theta = -((-pi/2) - thetast);
    THETAS = [THETAS; theta];
    %plot(THETAS);
    FrameNumber
    catch
     fprintf('error, ignoring');   
    end
    %for i = 1:3
    %thisFrame(:,:,i) = thisFrame(:,:,i) - greenproto(i);
    %thisFrame(:,:,i) = thisFrame(:,:,i) - min(min(thisFrame(:,:,i)));
    %thisFrame(:,:,i) = uint8(255*double(thisFrame(:,:,i))/double(max(max(thisFrame(:,:,i)))));
    %end
    %imshow(thisFrame);
    
    end

    %csvwrite(outputpath, THETAS);


end

function [lapout] = laplaceSmooth(x, box_width)
n = length(x);
[n1, n2] = size(x);
lapout = zeros(n1, n2);
for i = 1:n
   lapout = mean(x(max(1, i - box_width):min(n, i + box_width)));
end
end


function [lapout] = laplaceSmooth2(X, box_width)
[n1, n2] = size(X);
lapout = zeros(n1,n2);
for i = 1:n1
    lapout(i, :) = laplaceSmooth(X(i,:), box_width);
end
for j = 1:n2
    lapout(:, j) = laplaceSmooth(X(:,j), box_width);
end
end
