function [hd] = function_hamming_distance(V1, V2)
    %% Hamming Distance as power model
    dist =  bitxor(V1,V2);
    hd = reshape(sum(de2bi(dist),2), size(dist));
end

