% RC Lowpass Filter Simulation in Time Domain using ODE45 with Input Signal as Vector
clear;
clc;
close all;

% Parameters
R = 1e3;      % Resistance in ohms
C = 6e-9;     % Capacitance in farads

fs = 24e3;
duration = 0.01;

ts = 0:1/fs:duration;

% Define input signal as a vector (sinusoidal input)
Vin = sin(2*pi*1000*ts);

RC = R*C;

% Define the ODE as a function handle
% Interpolating Vin so it can be evaluated at arbitrary time points
odeFunc = @(t, Vout) (1/RC) * (interp1(ts, Vin, t) - Vout);

% Solve the ODE using ode45
[t_out, Vout] = ode45(odeFunc, ts, 0);

figure;
plot(t_out, Vout);