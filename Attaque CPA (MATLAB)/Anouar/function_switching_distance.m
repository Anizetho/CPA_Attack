function [sd] = function_switching_distance(V1, V2, delta)
    dist =  bitxor(V1,V2);
    hd = reshape(sum(de2bi(dist),2), size(dist));
    
    tmp1 = bsxfun(@bitand, V1, hd);
    
    hw_tmp1 = sum(de2bi(tmp1), 2);
    hw_tmp1 = reshape(hw_tmp1,size(tmp1));
    %hw_hd = sum(de2bi(hd), 2);
    sd = hd - delta*hw_tmp1;
    
end

