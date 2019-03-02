clear;
clc;

load('time.txt')
load('tracesTest.txt')
% N_traces = size(traces3,2)/505;
% N_Columns = size(traces3,2)/N_traces;
% traces = reshape(traces3,[N_traces,505]);
tracesX = time(1,:);
% tracesY = traces(5,:);
% figure()
% plot(tracesX, tracesY)

%% Plot 2D 4 traces
figure
subplot(2,2,1)
plot(tracesX, traces(1,:))
title('Première trace')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,2)
plot(tracesX, traces(2,:))
title('Deuxième trace')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,3)
plot(tracesX, traces(3,:))
title('Troisième trace')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,4)
plot(tracesX, traces(4,:))
title('Quatrième trace')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on


%% Plot 2D 4 traces
figure
subplot(2,2,1)
plot(tracesX, traces(20,:))
title('Trace 20')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,2)
plot(tracesX, traces(21,:))
title('Trace 21')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,3)
plot(tracesX, traces(22,:))
title('Trace 22')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,4)
plot(tracesX, traces(23,:))
title('Trace 23')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on


%% Plot 2D 4 traces
figure
subplot(2,2,1)
plot(tracesX, traces(300,:))
title('Trace 300')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,2)
plot(tracesX, traces(301,:))
title('Trace 301')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,3)
plot(tracesX, traces(302,:))
title('Trace 302')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
subplot(2,2,4)
plot(tracesX, traces(303,:))
title('Trace 303')
xlabel("Nombre d'échantillons")
ylabel('Tension')
grid on
