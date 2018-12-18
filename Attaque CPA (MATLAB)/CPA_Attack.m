%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         CPA attack (AES-256)   HW                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc ;
tic;

%% Configuration
mode = 32;
Nth_measurement = 'Test_4000';

%% Load the data
totalPath = strcat(path, Nth_measurement,'\');
traceFile = strcat(totalPath,'traces.txt');
traces_brute = csvread(traceFile);
traces=31.2500E-6*traces_brute;
plaintextFile = strcat(totalPath,'plaintexts.mat');
load(plaintextFile);
keyFile = strcat(totalPath,'keys_unique.mat');
True_Key = load(keyFile);

%% Simulate the algorithm
keys = [0:255];
len_keys = length(keys');
[nb_traces,nb_sampling] = size(traces);
nb_columns = mode*len_keys;
hypothetic_inter1 = zeros(nb_traces,nb_columns);
for byte=1:16
    hypothetic_inter1(:,[((256*mode)-(256*((mode+1)-byte)))+1:((256*mode)-(256*(mode-byte)))]) = bitxor(plaintexts(:,byte),keys);
end
toc;
hypothetic_inter2 = sbox(hypothetic_inter1);
bin_hypothetic_inter2 = dec2bin(hypothetic_inter2);
Weight_Hamm_desordonnate = sum(bin_hypothetic_inter2.' == '1');
Weight_Hamm = reshape(Weight_Hamm_desordonnate,[nb_traces,nb_columns]);
toc;

%% Calculate the correlation coefficient
coefficient = corr(Weight_Hamm, traces);
Result = coefficient';
toc;
        
%% Key values
Key_values = zeros(1,mode);
for i=1:16
    n_1 = (i*256)-255;
    n=i*256;
    [maximum,indice] = max(max(abs(Result(:,[n_1:n]))));
    Secret_Key = keys(indice);
    Key_values(1,i)=Secret_Key;
end
toc;

%% Second round
% True Result
XOR = bitxor(plaintexts,Key_values(1:16));
SboxResult = sbox(XOR);
ShiftRowsResult = shiftrows(SboxResult);
MixColumnResult = mixcolumns(ShiftRowsResult);
hypothetic_inter1(:,[((256*mode)-(256*((mode+1)-byte)))+1:((256*mode)-(256*(mode-byte)))]) = bitxor(MixColumnResult(:,(mode-16)),keys);
for byte=17:32
    hypothetic_inter1(:,[((256*mode)-(256*((mode+1)-byte)))+1:((256*mode)-(256*(mode-byte)))]) = bitxor(plaintexts(:,byte-16),keys);
end
hypothetic_inter2 = sbox(hypothetic_inter1);
bin_hypothetic_inter2 = dec2bin(hypothetic_inter2);
Weight_Hamm_desordonnate = sum(bin_hypothetic_inter2.' == '1');
Weight_Hamm = reshape(Weight_Hamm_desordonnate,[nb_traces,nb_columns]);
toc;

%% Calculate the correlation coefficient
coefficient = corr(Weight_Hamm, traces);
Result = coefficient';
toc;

%% Key values
for i=17:32
    n_1 = (i*256)-255;
    n=i*256;
    [maximum,indice] = max(max(abs(Result(:,[n_1:n]))));
    Secret_Key = keys(indice);
    Key_values(1,i)=Secret_Key;
end
toc;
