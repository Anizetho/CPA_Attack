function [V] = function_hypothetic_intermediate_2(state)
    %% Calculate hypothetical intermediate values
    n_traces = size(state,1);
    keys = 0:255;
    len_keys = length(keys);
    
    hypothetic_inter1 = zeros(n_traces,len_keys);
    for k = 1:len_keys
        hypothetic_inter1(:,k) = bitxor(state,keyz(k));
    end
    
    V = aes_sbox(hypothetic_inter1);
    
end

