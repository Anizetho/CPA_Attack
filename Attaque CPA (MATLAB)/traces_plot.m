clear ;
clc ;
tic;

%% Load the data
traces = csvread('traces.txt');

%% Plot 2D 4 traces
figure
subplot(2,2,1)
plot(traces(2000,:))
title('Première trace')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,2)
plot(traces(2,:))
title('Deuxième trace')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,3)
plot(traces(3,:))
title('Troisième trace')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,4)
plot(traces(2900,:))
title('Quatrième trace')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
toc;