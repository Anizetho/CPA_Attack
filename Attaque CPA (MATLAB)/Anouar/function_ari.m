function [ari] = function_ari(labels1,labels2)
    
    N = size(labels1,1);
    
    T = crosstab(labels1, labels2);

    A = sum(T,2);
    B = sum(T,1);

    t1  = sum((A.^2 - A)*0.5);
    t2 = sum((B.^2 - B)*0.5);
    t3 = (N^2-N)*0.5;

    I = sum(sum((T.^2-T)*0.5));
    MI = 0.5*(t1+t2);
    EI = (t1*t2)/t3;

    ari = (I-EI)/(MI-EI);
end

