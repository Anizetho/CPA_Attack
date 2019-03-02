clear;
clc ;
tic;

%% Configuration :
% - The user defines the AES's mode (128=16 ; 256=32)
% - The user defines the number of traces that he would like test
mode = 32;
NUMBER_TRACES = 5000;


% %% Plot data from oscilloscope (normal)
% traces_brute = load('testTraces2.csv');
% traces=31.2500E-6*traces_brute;
% plaintextFile = strcat(totalPath,'plaintexts.mat');
% load(plaintextFile);
% keyFile = strcat(totalPath,'keys_unique.mat');
% load(keyFile);
% 
% [y,x]=size(traces);
% OneTrace = traces(129,:);
% X = x;
% Y = OneTrace;
% figure()
% plot(A)


%% Plot Data from picoscope
load('20190227-0015.mat');
X = linspace(0,size(A,1)-1,size(A,1));
figure()
plot(X,A)
grid on;
hold on;

