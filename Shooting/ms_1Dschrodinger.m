%%% Author - M Shihar 
%%% ID     - 208628A 
%%% Electronics Devices 
%%% Shooting Method

clc; 
close all;
clear ;
tic;

%%
disp('Running Shooting Method Simulation of Schrodinger 1D Equation');
disp('Initialising Variables');
global m_e h_bar e V_upper V_lower A_0 Wb Lw epsilon;
m_e = 9.11e-31;       %mass of electron
e = 1.602e-19;        %charge of electron to convert for eV
h_bar = 1.055e-34;     %planks constant divided by 2 
A_0 = 10^10;    % convert angstrom to nm ease of plotting the xaxis

%% Init variables for potential wells

V_upper = 10;
V_lower = 0 ;
Lw = 8e-10; %in nm 
Wb = Lw/2 ; %well boundary 
N = 1000;
x = linspace(-Lw,Lw,N);   %in nm 
dx = x(2)-x(1);
epsilon = 1e-5;   %tolerance level for shooting method

%% potential functions to run the 1D sim 
disp('Generating Potential Function');
sel = 1 ;        %Linear 
sel = 2   ;     %Quadratic 
% sel = 3  ;      %Harmonic
%sel = 0   ;     %Square 

%debug = true;   %to view potential function
debug = false ;

V  = potentialGenShooting(sel,x,debug);

%% setting up Energy values for shooting method 
disp('Generating Energy Vector for Shooting Method');
E1 = 0;                        
E2 = 10;                        
nE = 10000001;  
E = linspace(E1,E2,nE);     %build the energy vector to loop through for shooting method

%% find eigen energies using shooting method 
disp('Shooting Simulation for Calculating Energy States')
%function to find eigen energy 
Energy = EigenSim(E,V,dx,N) ;%find eigen energies 

%% plot again the functions properly with proper E values
disp('Plotting Wave Functions')
PlotGraphs(Energy,V,dx,N,x);
toc;
disp('End of Simulation')