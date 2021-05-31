%%% Author - M Shihar 
%%% ID     - 208628A 
%%% Electronics Devices 
%%% Eigen Method



clc; 
close all;
clear ;
tic;

disp('Running Eigen Method Simulation of Schrodinger 1D Equation');
disp('Initialising Variables');

%use global variables so amount arguments passed to function simplifies
global m_e h_bar e V_upper V_lower Wb Lw A_0;
m_e = 9.11e-31;
e = 1.602e-19;
h_bar = 1.055e-34;
A_0 = 10^10;

C =-h_bar^2/2/m_e;

%% Init variables for potential wells
V_upper = 10;
V_lower = 0 ;

Lw = 8e-10; %in nm 
Wb = Lw/2 ; %well boundary 
N = 1000;
x = linspace(-Lw,Lw,N);   %in nm 
dx = x(2)-x(1); %difference between two discretized points

%% Building Potential Energy Matrix 
disp('Generating Potential Function');

%uncomment to run a particular function 
%sel = 1;     %Linear 
%sel = 2;    %Quadratic 
%sel = 3;    %Harmonic
sel = 4;    %Square
%sel = 5;    %stepped Well
%sel = 6;    %Double Well
%sel = 7;    %triangle well
%sel = 8;    %series potential well
%sel = 9;    %Assymetrical Double Well
%sel = 10;   %free particle

% debug = true;   %to view potential function
debug = false ;

[V_hat,V] =potential_Generator(sel,x,debug);


%% Building Hamilton Matrix 

disp('Developing Hamilton Matrix');

%Build Kinetic Energy Matrix 
T_hat = zeros(length(x),length(x));
for r = 1:length(x)
    T_hat(r,r) = -2;
    T_hat(r,r+1) = 1;
    T_hat(r+1,r) = 1;
end

T_hat(length(x)+1,:) = [];
T_hat(:,length(x)+1) = [];

Cdx = C/dx^2;

%% Eigen Calculations

% Hamilton Matrix Join Kinetic Energy Matrix With Potential Energy Matrix 
H_hat = Cdx*T_hat + V_hat;

%solve using eig
[psi_e,Energy] = eig(H_hat);

%%

disp('Calculating of Energy States');
E = diag(Energy)/e;
r =5;
E = E(1:r);

%filter out unique ones 
c = 1;
E_old = 0;
% for i=1:length(E)
%     if abs(E(i) - E_old) > 0.5;%  && E(i) < V_upper;
%         E_new(c) = E(i) ;
%         c= c+1;
%         E_old = E(i);
%     end
% end

%EnergyPlotter(x,V/e,E,8,8,2,12); 
psi = psi_e(:,1:r);

disp('Plotting Wave Functions');
PlotGraphsE(-psi,E,V/e,dx,N,x)

toc;

