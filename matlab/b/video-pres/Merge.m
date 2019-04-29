clear
close all
clc
data = csvread('./data/t_exp_sim_v1.csv');
framerate = 29; %input framerate
t = linspace(0,4*1.2684,150);
assimdata_sim = zeros(1, length(t));
assimdata_exp = zeros(1, length(t));
for i = 1:length(t)
    [ss, ee] = Interp2(t(i), data);
    assimdata_sim(i) = ss;
    assimdata_exp(i) = ee;
end
figure
for i = 1:150
    plot(t, assimdata_sim, '--', 'color', [0 0 0.7], 'LineWidth', 2,'HandleVisibility','off');
    hold on
    plot(t, assimdata_exp, '--', 'color', [0.7 0 0], 'LineWidth', 2,'HandleVisibility','off');
    curexp = assimdata_exp(1:i);
    cursim = assimdata_sim(1:i);
    curt = t(1:i);
    hold on
    plot(curt, cursim, 'LineWidth', 3, 'color', [0 0 0.85]);
    hold on
    plot(curt, curexp, 'LineWidth', 3, 'color', [0.85 0 0]);
    legend('Simulation','Experiment');
    tc = curt(end);
    ec = curexp(end);
    sc = cursim(end);
    hold on
    plot(tc, ec, 'o', 'color', [0.5 0 0], 'MarkerFaceColor', [1 0 0],'HandleVisibility','off');
    hold on
    plot(tc, sc, 'o', 'color', [0 0 0.5], 'MarkerFaceColor', [0 0 1],'HandleVisibility','off');
    hold off
    ylabel('\theta', 'FontSize', 18)
    xlabel('t', 'FontSize', 18)
    drawnow
    saveas(gcf, strcat('./plot_frames/plot_',fnum2str(i),'.png'));
    pause(1/framerate);
end
