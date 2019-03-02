%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         CPA attack (AES-256)   HW                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;
clc ;
tic;

%% Configuration :
% - The user defines the AES's mode (128=16 ; 256=32)
% - The user defines the number of traces that he would like test
mode = 32;
NUMBER_TRACES = 500;

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

%time = load('time.txt');
%traces = load('traces.txt');

%% Simulate the algorithm
keys = [0:255];
len_keys = length(keys');
[nb_traces,nb_sampling] = size(traces);
nb_columns = (mode/2)*len_keys;
hypothetic_inter1 = zeros(nb_traces,nb_columns);
for byte=1:16
    hypothetic_inter1(:,[((256*mode)-(256*((mode+1)-byte)))+1:((256*mode)-(256*(mode-byte)))]) = bitxor(plaintexts(:,byte),keys);
end
hypothetic_inter2 = sbox(hypothetic_inter1);
bin_hypothetic_inter2 = dec2bin(hypothetic_inter2);
Weight_Hamm_desordonnate = sum(bin_hypothetic_inter2.' == '1');
%Weight_Hamm = reshape(Weight_Hamm_desordonnate,[nb_traces,nb_columns]);
Weight_Hamm = reshape(Weight_Hamm_desordonnate,[nb_traces,size(hypothetic_inter2,2)]);
clc;
pourcent = 10;
fprintf(formatSpec,pourcent)
%toc;

%% Calculate the correlation coefficient
coefficient = corr(Weight_Hamm, traces);
Result = coefficient';
clc;
pourcent = 30;
fprintf(formatSpec,pourcent)
%toc;
        
%% Key values
Key_values = zeros(1,mode/2);
for i=1:16
    n_1 = (i*256)-255;
    n=i*256;
    [maximum,indice] = max(max(abs(Result(:,[n_1:n]))));
    Secret_Key = keys(indice);
    Key_values(1,i)=Secret_Key;
end
clc;
pourcent = 50;
fprintf(formatSpec,pourcent)
%toc;

%% Second round
if mode == 32
    % True Result
    XOR = bitxor(plaintexts,Key_values(1:16));
    SboxResult = sbox(XOR);
    ShiftRowsResult = shiftrows(SboxResult);
    MixColumnResult = mixcolumns(ShiftRowsResult);
    hypothetic_inter1_secondRd = zeros(nb_traces,nb_columns);
    for byte=1:16
        hypothetic_inter1_secondRd(:,[((256*mode)-(256*((mode+1)-byte)))+1:((256*mode)-(256*(mode-byte)))]) = bitxor(MixColumnResult(:,byte),keys);
    end
    hypothetic_inter2_secondRd = sbox(hypothetic_inter1_secondRd);
    clc;
    pourcent = 75;
    fprintf(formatSpec,pourcent)

    for byte=1:16
        Col = [((256*mode)-(256*((mode+1)-byte)))+1:((256*mode)-(256*(mode-byte)))];
        dist(:,Col) =  bitxor(SboxResult(:,byte),hypothetic_inter2_secondRd(:,Col));
    end
    bin_dist = dec2bin(dist); % Jusqu'ici Okay !
    Dist_hamming_desordonnate = sum(bin_dist.' == '1');
    Dist_hamming = reshape(Dist_hamming_desordonnate,[nb_traces,nb_columns]);
    clc;
    pourcent = 95;
    fprintf(formatSpec,pourcent)
    %toc;

    %% Calculate the correlation coefficient
    coefficient_secondRd = corr(Dist_hamming, traces);
    Result_secondRd = coefficient_secondRd';
    %toc;

    %% Key values
    Key_values_secondRd = zeros(1,16);
    for i=1:16
        n_1 = (i*256)-255;
        n=i*256;
        [maximum,indice] = max(max(abs(Result_secondRd(:,[n_1:n]))));
        Secret_Key = keys(indice);
        Key_values_secondRd(1,i)=Secret_Key;
    end
end
clc;
pourcent = 100;
fprintf(formatSpec,pourcent)
%toc;

%% To compare the keys
if mode == 16
    ResponseObtained = Key_values';
    ResponseExcepted = keys_unique';
elseif mode == 32
    Key_values = [Key_values, Key_values_secondRd];
    ResponseObtained = Key_values';
    ResponseExcepted = keys_unique';    
end


%% Print result
clc;
error = 0;
fprintf('=> Results : \n');  

% Round 1
fprintf('-> Attack Round 1 \n');  
fprintf('N�  Byte  : ');
for i=1:mode/2
    if i<10
        fprintf('%i     ', i);  
    else    
        fprintf('%i    ', i); 
    end
end
fprintf('\n');
fprintf('Real  Key : ');
for i=1:mode/2
    fprintf('0x%s  ', dec2hex(ResponseExcepted(i), 2));  
end
fprintf('\n');
fprintf('Found Key : ');
for i=1:mode/2
    if ResponseExcepted(i) ==  ResponseObtained(i)
        fprintf('0x%s  ', dec2hex(ResponseObtained(i), 2));
    else
        fprintf(2,'0x%s  ', dec2hex(ResponseObtained(i), 2));
        error = error + 1;
    end
end

% Round 2
fprintf('\n \n');
fprintf('-> Attack Round 2 \n'); 
fprintf('N�  Byte  : ');
for i=1:mode/2
    if i<10
        fprintf('%i     ', i);  
    else    
        fprintf('%i    ', i); 
    end
end
fprintf('\n');
fprintf('Real  Key : ');  
for i=17:32
    fprintf('0x%s  ', dec2hex(ResponseExcepted(i), 2));  
end
fprintf('\n');
fprintf('Found Key : ');
for i=17:32
    if ResponseExcepted(i) ==  ResponseObtained(i)
        fprintf('0x%s  ', dec2hex(ResponseObtained(i), 2));
    else
        fprintf(2,'0x%s  ', dec2hex(ResponseObtained(i), 2));
        error = error + 1;
    end
end

fprintf('\n \n');
formatSpec = '==> There are %i byte(s) of error (on %i bytes) for %i traces. \n';
fprintf(formatSpec,error, mode, nb_traces)


