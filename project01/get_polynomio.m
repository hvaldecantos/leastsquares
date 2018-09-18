function p = get_polynomio(degree)
    p = {};
    for i=0:degree
        p{i+1} = {str2func(sprintf("@(x) x.^%d",i)), 1};
    end
end