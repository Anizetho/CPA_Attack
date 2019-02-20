clear ;
clc ;
tic;

%% Load the data
Nth_measurement = 'Test_3000';
path = '..\Data\Multiple_Keys_Measurements\Measurement_';
totalPath = strcat(path, Nth_measurement,'\');
traceFile = strcat(totalPath,'traces.txt');
traces_brute = csvread(traceFile);
traces=31.2500E-6*traces_brute;

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