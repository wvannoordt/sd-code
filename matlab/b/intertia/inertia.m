clear all;
close all;
clc;

M_noodle_full=0.912;    %Lbs, https://www.andymark.com/products/pool-noodle-qty-6-55-in-x-2-5-in
L_noodle_full=55;       %In
dia_noodle=2.5;         %In
area_noodle=3.1415*(dia_noodle/2)^2;
vol_noodle_full=area_noodle*L_noodle_full;
density_noodle=M_noodle_full/vol_noodle_full;   %lb/in^3

%******DEFINE LENGTH HERE******
L_noodle=24;    %In



M_noodle=density_noodle*area_noodle*L_noodle;   %Lbs
noodle_I=1/3*M_noodle*L_noodle^2;      %Rod about end formula, 1/3ML^2  lb*in^2
metric_noodle_I=noodle_I*0.0254^2*0.453592  %kg*m^2

