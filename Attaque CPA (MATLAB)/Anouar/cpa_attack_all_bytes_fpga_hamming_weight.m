clear
clc
close all

%% Load Traces
Nth_measurement = 'Test_6000';
path = '..\..\Data\Multiple_Keys_Measurements\Measurement_';
totalPath = strcat(path, Nth_measurement,'\');
traceFile = strcat(totalPath,'traces.txt');
traces_brute = csvread(traceFile);
traces=31.2500E-6*traces_brute;
plaintextFile = strcat(totalPath,'plaintexts.mat');
load(plaintextFile);
keyFile = strcat(totalPath,'keys_unique.mat');
load(keyFile);

nameFile = '/traces.txt';
YMult = 31.25e-6;

[T, plaintexts, key, ciphertexts] = import_data(path, Nth_measurement, nameFile, YMult);
load(strcat(path, Nth_measurement,'/keys_unique.mat'));
key = keys_unique;
nb_traces   = size(T,1);
nb_samples  = size(T,2);

%%
fprintf('Attack Round 1 \n \n');  
fprintf('Real  Key : ');  
for i=1:16
    fprintf('0x%s  ', dec2hex(key(i), 2));  
end
fprintf('\n');
fprintf('Found Key : ');
key_found = zeros(1,32);
%% Compute hypothetic intermediate
for byte_to_attack=1:16
    pt_byte = plaintexts(:,byte_to_attack);

    V = function_hypothetic_intermediate(pt_byte);
    H = function_hamming_weight(V);
    R = corr(H,T);
    [~, ind] = max(abs(R(:)));
    [key_tmp, time_leakage] = ind2sub(size(R),ind);
    key_found(byte_to_attack) = key_tmp - 1;
    
    if key_found(byte_to_attack) ==  key(byte_to_attack)
        fprintf('0x%s  ', dec2hex(key_found(byte_to_attack), 2));
    else
        fprintf(2,'0x%s  ', dec2hex(key_found(byte_to_attack), 2));
    end
end
fprintf('\n');

%%
fprintf('\n');
fprintf('Attack Round 2 \n \n');  
fprintf('Real  Key : ');  
for i=17:32
    fprintf('0x%s  ', dec2hex(key(i), 2));  
end
fprintf('\n');
fprintf('Found Key : '); 
%% 2nd round
state = zeros(size(plaintexts));
for i = 1:nb_traces
    state(i,:) = bitxor(plaintexts(i,:),key_found(1:16));
%     state(i,:) = bitxor(plaintexts(i,:),key(1:16));
end

state2 = aes_sbox(state);
state = aes_shiftrows(state2);
state = aes_mixcolumns(state);
for byte_to_attack=17:32
    state_byte = state(:,byte_to_attack-16);
    V = function_hypothetic_intermediate(state_byte);
%   H = function_hamming_distance(V,state2(:,byte_to_attack-16));
    H = function_switching_distance(state2(:,byte_to_attack-16), V, 0);
    %% correlation
    R = corr(H,T);
    [~, ind] = max(abs(R(:)));
    [key_tmp, time_leakage] = ind2sub(size(R),ind);
    key_found(byte_to_attack) = key_tmp - 1;
    
    if key_found(byte_to_attack) ==  key(byte_to_attack)
        fprintf('0x%s  ', dec2hex(key_found(byte_to_attack), 2));
    else
        fprintf(2,'0x%s  ', dec2hex(key_found(byte_to_attack), 2));
    end
end
fprintf('\n');