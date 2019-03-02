clear;
clc ;
tic;

%% Configuration :
% - The user defines the AES's mode (128=16 ; 256=32)
% - The user defines the number of traces that he would like test
mode = 32;
NUMBER_TRACES = 5000;

%% Load the data
Nth_measurement = strcat(int2str(NUMBER_TRACES),'_traces');
formatSpec = 'In progress %i%% ... \n';
pourcent = 2;
fprintf(formatSpec,pourcent)
path = '..\Data\AES_256\Measurement_';
totalPath = strcat(path, Nth_measurement,'\');
traceFile = strcat(totalPath,'traces.txt');
traces_brute = csvread(traceFile);
traces=31.2500E-6*traces_brute;
plaintextFile = strcat(totalPath,'plaintexts.mat');
load(plaintextFile);
keyFile = strcat(totalPath,'keys_unique.mat');
load(keyFile);
clc
pourcent = 5;
fprintf(formatSpec,pourcent)

%% Plot One trace
figure()
X = linspace(0,size(traces,1)-1,size(traces,1));
plot(traces(1,:))
grid on;

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