% NSGA2_Optimization.m
clc
clear
close all

% Number of variables and optimization features 
nvars = 6;                 
PopulationSize=5;
MaxGenerations=5;
CrossoverFraction=0.8;
FunctionTolerance=1e-4;

% Variable bounds
lb = [1, 1, 1, 1, 0.0001 0];
ub = [400, 400, 400, 400, 1 4000];

% Define mutation rate
mutationRate = 0.02; % 2% mutation rate

% Define initial starting values for one individual
initialStartValues = [200, 150, 100, 50, 0.1 3000]; % Example starting values within bounds

initialPopulation = [
    initialStartValues; % Starting values for first individual
    lb + (ub - lb) .* rand(PopulationSize, nvars) % Random values for the rest of the population
];

% Define options for NSGA-II
options = optimoptions('gamultiobj', ...
    'PopulationSize', PopulationSize, ...
    'MaxGenerations', MaxGenerations, ...
    'InitialPopulationMatrix', initialPopulation, ... % Set initial population
    'Display', 'iter', ...
    'CrossoverFraction', CrossoverFraction, ...
    'MutationFcn', {@mutationuniform, mutationRate}, ... % Custom mutation function with rate
    'SelectionFcn', @selectiontournament, ... % Tournament selection function
    'FunctionTolerance', FunctionTolerance); ... % Custom plotting function
    
%'PlotFcn', @plotParetoFronts
    
% Run NSGA-II using the cost function
[x, fval, exitflag, output, population, scores] = gamultiobj(@costFunction, ...
    nvars, [], [], [], [], lb, ub, options);


% disp('Pareto optimal points (variable values):');
% disp(x);
% disp('Objective values at Pareto optimal points:');
% disp(fval);
% 
% % Final Pareto Front Plot in 3D
% figure;
% plot3(fval(:,1), fval(:,2), fval(:,3), 'bo');
% xlabel('Objective 1');
% ylabel('Objective 2');
% zlabel('Objective 3');
% title('Final Pareto Front');
% grid on;