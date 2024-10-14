clc;
clear;
close all;

%% Parameter Section

input_f = 1e3; %Frequency of the input signal (sine)
input_ampl = 0.25; %Amplitude of the input signal (sine)
f_s = 24e3; %Sampling frequency of the input signal (sine)

sd_osr = 32; %Oversampling rate (OSR) of the sigma delta modulator
sd_bits = 12; %Number of bits of the sigma delta modulator

sim_duration = 0.01; %Duration of the simulation in seconds



%% Signal Creation Section

%Calculating time vectors
s_t = 0:1/f_s:sim_duration; %Time vector for sampling the input signal
sd_t = 0:1/(sd_osr * f_s):sim_duration; %Time vector for the sigma delta modulator

%Storing the lengths of the time vectors
s_length = length(s_t);
sd_length = length(sd_t);

%Preparing vectors for the integrators, the feedback signal and the output
%of the sigma delta modulator
sd_integrator0 = zeros(1, sd_length);
sd_integrator1 = zeros(1, sd_length);
sd_feedback = zeros(1, sd_length);
sd_output = zeros(1, sd_length);

%Calculating the max value, the min value and the threshold of the sigma
%delta modulator
sd_max_value = bitshift(1, sd_bits) - 1;
sd_min_value = 0;
sd_threshold = bitshift(1, sd_bits - 1);

%Creating an input signal
input = sd_max_value*0.5*(input_ampl*sin(2*pi*input_f*s_t)+1);

for i = 1:(s_length - 1)
    for n = 1:sd_osr
        sd_buffer_pos = (i - 1) * sd_osr + n;

        if sd_buffer_pos == 1
            continue
        end

        if sd_output(sd_buffer_pos-1) == 1
            sd_feedback(sd_buffer_pos) = sd_max_value;
        else
            sd_feedback(sd_buffer_pos) = sd_min_value;
        end
    
        sd_integrator0(sd_buffer_pos) = sd_integrator0(sd_buffer_pos-1) - sd_feedback(sd_buffer_pos) + input(i);
        sd_integrator1(sd_buffer_pos) = sd_integrator1(sd_buffer_pos-1) - sd_feedback(sd_buffer_pos) + sd_integrator0(sd_buffer_pos);
    
        if sd_integrator1(sd_buffer_pos) >= sd_threshold
            sd_output(sd_buffer_pos) = 1;
        else
            sd_output(sd_buffer_pos) = 0;
        end
    end
end



%% RC lowpass section

rc_input = 3.3 * sd_output;

% Parameters
R = 1e3;      % Resistance in ohms
C = 31e-9;     % Capacitance in farads
RC = R*C;

% Define the ODE as a function handle
odeFunc = @(t, Vout) (1/RC) * (interp1(sd_t, rc_input, t) - Vout);

% Solve the ODE using ode45
[t_out, Vout] = ode45(odeFunc, sd_t, 0);

vin_ideal = interp1(s_t, input*(3.3/sd_max_value), t_out);

%% Plot Section

figure

subplot(5, 1, 1);
stem(s_t, input);

subplot(5, 1, 2);
stem(sd_t, sd_integrator0);

subplot(5, 1, 3);
stem(sd_t, sd_integrator1);

subplot(5, 1, 4);
stem(sd_t, sd_output);

subplot(5, 1, 5);
plot(t_out, Vout);
hold on;
plot(t_out, vin_ideal);
hold off;

snr_measured = snr(vin_ideal, Vout - vin_ideal);