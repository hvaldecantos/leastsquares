function p = get_polynomial(degree, vars)
    index = 1;
    p{index} = {str2func(sprintf("@(x) ones(length(x),1)")), 1};
    
    for v = 1:length(vars)
        if(vars(v) ~= "na")
            for i=1:degree
                index = index + 1;
                p{index} = {str2func(sprintf("@(%s)(%s.^%d)",vars(v),vars(v),i)), v};
            end
        end
    end
end
