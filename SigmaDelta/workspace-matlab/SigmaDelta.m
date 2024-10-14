clc;
clear;
close all;

input = 4094;
sd_bits = 12;
sim_length = 100000;

sd_integrator0 = zeros(1, sim_length);
sd_feedback = zeros(1, sim_length);
sd_output = zeros(1, sim_length);

sd_max_value = bitshift(1, sd_bits) - 1;
sd_min_value = 0;
sd_threshold = bitshift(1, sd_bits - 1);

for i = 2:sim_length
    if sd_output(i-1) == 1
        sd_feedback(i) = sd_max_value;
    else
        sd_feedback(i) = sd_min_value;
    end

    sd_integrator0(i) = sd_integrator0(i-1) - sd_feedback(i) + input;

    if sd_integrator0(i) >= sd_threshold
        sd_output(i) = 1;
    else
        sd_output(i) = 0;
    end
end

m = mean(sd_output)*sd_max_value;

figure

subplot(2, 1, 1);
stem(sd_output);

subplot(2, 1, 2);
plot(sd_integrator0);