clear
clc

%% The user defines the number of traces
NUMBER_TRACES = 4000;

%% To load the data
Nth_measurement = strcat(int2str(NUMBER_TRACES),'_traces');
path = '..\Data\AES_256\Measurement_';
mkdir(strcat(path, Nth_measurement));
file = fopen('..\Data\AES_256\FileForName.txt','w');
fprintf(file,'%s\n',Nth_measurement);
fclose(file);

%% Inputs
n_keys          = 1;
n_ppk           = NUMBER_TRACES;
n_plaintexts    = n_keys*n_ppk;

size_key        = 32;
%% Generate key
keys_unique = randi([0 255], n_keys, 32);
keys        = repmat(keys_unique, n_ppk, 1);
labels      = repmat((1:n_keys)',n_ppk,1);
idx         = randperm(n_plaintexts)';
keys        = keys(idx,:);
labels      = labels(idx);
save(strcat(path, Nth_measurement,'\labels.mat'),'labels');

keys_rshp = reshape(keys.', n_plaintexts*size_key,1);
keys_hex1 = dec2hex(keys_rshp,2);
keys_hex  = reshape(keys_hex1.', n_plaintexts*2*size_key,1);
keys_hex  = reshape(keys_hex, 2*size_key, n_plaintexts).';

fid = fopen(strcat(path, Nth_measurement,'\keys.txt'),'w');
for i =1:n_plaintexts
    fprintf(fid,keys_hex(i,:));
    fprintf(fid, '\n');
end
fclose(fid);

keys_hex_fpga = "00" + keys_hex(:,1:32) + "01" + keys_hex(:,33:64);

fid = fopen(strcat(path, Nth_measurement,'\keys_fpga.txt'),'w');
for i =1:n_plaintexts
    fprintf(fid,keys_hex_fpga(i,:));
    fprintf(fid, '\n');
end
fclose(fid);

save(strcat(path, Nth_measurement,'\keys_unique.mat'),'keys_unique');

keys_unique_rshp = reshape(keys_unique.', n_keys*size_key,1);
key_unique_hex = dec2hex(keys_unique_rshp,2);
key_unique_hex  = reshape(key_unique_hex.', n_keys*2*size_key,1);
key_unique_hex  = reshape(key_unique_hex, 2*size_key, n_keys).';

fid = fopen(strcat(path, Nth_measurement,'\keys_unique.txt'),'w');
for i =1:n_keys
    fprintf(fid,key_unique_hex(i,:));
    fprintf(fid, '\n');
end
fclose(fid);

%% Labels
fid = fopen(strcat(path, Nth_measurement,'\labels.txt'),'w');
for i =1:n_plaintexts
    fprintf(fid, num2str(labels(i)));
    fprintf(fid, '\n');
end
fclose(fid);
%% Generate plaintexts
plaintexts = randi([0 255], n_plaintexts, 16);
save(strcat(path, Nth_measurement,'\plaintexts.mat'),'plaintexts')

plaintexts = reshape(plaintexts.', n_plaintexts*16,1);
plaintexts_hex1 = dec2hex(plaintexts,2);
plaintexts_hex = reshape(plaintexts_hex1.', n_plaintexts*32,1);
plaintexts_hex = reshape(plaintexts_hex, 32,n_plaintexts).';

plaintexts_fpga = "03"+plaintexts_hex;

fid = fopen(strcat(path, Nth_measurement,'\pt.txt'),'w');
for i =1:n_plaintexts 
    fprintf(fid,plaintexts_hex(i,:));
    fprintf(fid, '\n');
end
fclose(fid);

fid = fopen(strcat(path, Nth_measurement,'\pt_fpga.txt'),'w');
for i =1:n_plaintexts 
    fprintf(fid,plaintexts_fpga(i,:));
    fprintf(fid, '\n');
end
fclose(fid);