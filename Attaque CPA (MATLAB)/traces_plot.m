clear ;
clc ;
tic;

%% Load the data
traces = csvread('traces.txt');

%% Plot 2D 4 traces
figure
subplot(2,2,1)
plot(traces(2000,:))
title('Premi�re trace')
xlabel("Nombre d'�chantillons")
ylabel('Tension')
grid on
subplot(2,2,2)
plot(traces(2,:))
title('Deuxi�me trace')
xlabel("Nombre d'�chantillons")
ylabel('Tension')
grid on
subplot(2,2,3)
plot(traces(3,:))
title('Troisi�me trace')
xlabel("Nombre d'�chantillons")
ylabel('Tension')
grid on
subplot(2,2,4)
plot(traces(2900,:))
title('Quatri�me trace')
xlabel("Nombre d'�chantillons")
ylabel('Tension')
grid on
toc;