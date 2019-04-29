clear
clc
close all

%%(ish)   v1  v2  v3
starts = [307 75 210]
lengths =[150 85 150]

startnum = 307+28;
endnum = startnum + 150 - 1;
sizemarker = 10;
markerColor = [255 0 0];
markerColor = uint8(markerColor);
cut = 500;
%janky and weird
vidnum = 1;
path = strcat('./video/v', num2str(vidnum),'.mp4');
FrameNumber = 1;
hinge = [35, 420];
greenproto = [108 135 92];
mov = VideoReader(path);
video = read(mov, [startnum endnum]);
THETAS = [];
figure
z = 1;
[~,~,~,ct] = size(video);
for i = 1:ct
    %imshow(thisFrame);
    FrameNumber = FrameNumber + 1;
    thisFrame = video(:,:,:,i);
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
    disp = cat(2,thisFrame(:,[1:cut],:),filterimgwhole(:,[1:cut],:));
    disp = custom_insertMarker(disp,hinge + [size(thisFrame(:,[1:cut],:),2),0], markerColor, sizemarker);
    disp = custom_insertMarker(disp,hinge, markerColor, sizemarker);
    stats = regionprops(filterbw);
    centroids = cat(1, stats.Centroid);
    areas = cat(1, stats.Area);
    truecentroid = [sum(areas.*centroids(:,1)), sum(areas.*centroids(:,2))]/sum(areas);
    disp = custom_insertMarker(disp,truecentroid + [size(thisFrame(:,[1:cut],:),2),0], markerColor, sizemarker);
    disp = custom_insertMarker(disp,truecentroid, markerColor, sizemarker);
    imshow(disp)
    delta = truecentroid - hinge;
    thetast = atan2(-delta(2), delta(1));
    theta = -((-pi/2) - thetast);
    THETAS = [THETAS; theta];
    %plot(THETAS);
    FrameNumber
    %for i = 1:3
    %thisFrame(:,:,i) = thisFrame(:,:,i) - greenproto(i);
    %thisFrame(:,:,i) = thisFrame(:,:,i) - min(min(thisFrame(:,:,i)));
    %thisFrame(:,:,i) = uint8(255*double(thisFrame(:,:,i))/double(max(max(thisFrame(:,:,i)))));
    %end
    drawnow
    %thisFrame = cat(2, thisFrame(:,[1:cut],:), filterimgwhole(:,[1:cut],:));
    imwrite(disp, strcat('vid_frames/frame_', fnum2str(z), '.png'));
    z = z+1;

    %csvwrite(outputpath, THETAS);
end