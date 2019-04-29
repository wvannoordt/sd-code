clear
clc
close all

plotexts = [1 25 49 74 97];
imexts = [1 20 39 58 77];
a = polyfit(imexts,plotexts,1);
scatter(imexts, plotexts)
hold on
plot(imexts, a(2)+a(1)*imexts);
a(1)