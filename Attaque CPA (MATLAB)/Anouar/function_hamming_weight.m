function [H] = function_hamming_weight(V)

    H = reshape(sum(de2bi(V),2), size(V));
end

