clc;
clear;
close all;

input = 500;
sd_bits = 12;
sim_length = 5000;

sd_integrator0 = zeros(1, sim_length);
sd_integrator1 = zeros(1, sim_length);
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
    sd_integrator1(i) = sd_integrator1(i-1) - sd_feedback(i) + sd_integrator0(i);

    if sd_integrator1(i) >= sd_threshold
        sd_output(i) = 1;
    else
        sd_output(i) = 0;
    end
end

output_mean = zeros(1, sim_length);
for i = 1:sim_length
    output_mean(i) = mean(sd_output(1:i))*sd_max_value; 
end

figure

subplot(4, 1, 1);
stem(sd_output);

subplot(4, 1, 2);
plot(sd_integrator0);

subplot(4, 1, 3);
plot(sd_integrator1);

subplot(4, 1, 4);
plot(output_mean);
hold on;
plot(input*ones(1, sim_length), 'Color', 'red');
hold off;