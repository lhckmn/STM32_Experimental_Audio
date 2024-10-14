% RC Lowpass Filter Simulation in Time Domain using ODE45 with Input Signal as Vector
clear;
clc;
close all;

% Parameters
R = 1e3;      % Resistance in ohms
C = 14e-9;     % Capacitance in farads
f_input = 1000; % Input signal frequency in Hz (sinusoidal input)
fs = 100e3;
duration = 5e-3;

t_input = 0:1/fs:duration;
Vin = 0.5*(sin(2*pi*10000*t_input)+1);


RC = R*C;
odeFunc = @(t, Vout) (1/RC) * (interp1(t_input, Vin, t) - Vout);
[t_out, Vout] = ode45(odeFunc, t_input, 0);


Vin_out = interp1(t_input, Vin, t_out);

% Plotting the input and output signals
figure;
plot(t_out, Vin_out, 'b', 'DisplayName', 'Input Signal (Vin)');
hold on;
plot(t_out, Vout, 'r', 'DisplayName', 'Filtered Signal (Vout)');
title('RC Lowpass Filter Simulation using ODE45 with Input Signal as Vector');
xlabel('Time (ms)');
ylabel('Voltage (V)');
legend show;
grid on;
