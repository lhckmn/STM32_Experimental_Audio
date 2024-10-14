% RC Lowpass Filter Simulation in Time Domain using ODE45
clear;
clc;
close all;

% Parameters
R = 1e3;      % Resistance in ohms
C = 1e-6;     % Capacitance in farads
f_input = 100; % Input signal frequency in Hz (sinusoidal input)
T = 1/(10*f_input); % Time period for 10x oversampling

t_sim = [0 100e-3]; % Simulation time vector (0 to 5 ms)
t_step = 1e-6;    % Time step for output resolution

% Define input signal (sinusoidal input)
Vin = @(t) sin(2*pi*f_input*t); 

% Define the RC filter ODE:
% dVout/dt = (1/(R*C)) * (Vin(t) - Vout(t))

RC = R * C; % RC time constant

% Define the ODE as a function handle
odeFunc = @(t, Vout) (1/RC) * (Vin(t) - Vout);

% Initial condition (Vout at t=0 is assumed to be 0)
Vout0 = 0;

% Solve the ODE using ode45
[t_out, Vout] = ode45(odeFunc, 0:t_step:t_sim(2), Vout0);

% Compute the input signal for the output time vector
Vin_out = Vin(t_out);

% Plotting the input and output signals
figure;
plot(t_out*1e3, Vin_out, 'b', 'DisplayName', 'Input Signal (Vin)');
hold on;
plot(t_out*1e3, Vout, 'r', 'DisplayName', 'Filtered Signal (Vout)');
title('RC Lowpass Filter Simulation using ODE45');
xlabel('Time (ms)');
ylabel('Voltage (V)');
legend show;
grid on;
