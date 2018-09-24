d = importdata("traindata.txt");
test = importdata("testinputs.txt");
X = d(:,1:8); Y = d(:,9);

max_p = 10;
vars = ["x1" "x2" "x3" "x4" "x5" "x6" "x7" "x8"];

all_combinations = get_combination(vars);

results = zeros((max_p + 1)*length(all_combinations), 2);
results_vars = repmat("", length(results), length(vars));

smallestR = 999999;
whenP = 0;
whenVars = repmat("", 1, length(vars));

idx = 1;
for p=0:max_p
    for v=1:length(all_combinations) 
        expansion = get_polynomial(p, all_combinations(v,:));
        Z = expand(expansion, X);
        [M R w] = least_squares(Z, Y);
        results(idx, :) = [p R];
        results_vars(idx, :) = all_combinations(v, :);
        idx = idx + 1;
        if(R < smallestR)
            smallestR = R;
            whenP = p;
            whenVars(1,:) = all_combinations(v,:);
        end
    end
end
plot(results);

message = "Minimal error found in polynomial order %d\nwhen variables used are: [%s]\nThe MSE found is: %f";
sprintf(message, whenP, join(whenVars), smallestR/length(Y))


function [A] = get_combination(vars)
    n = numel(vars);
    max = (2^n)-1;
    pad_size = length(dec2bin(max));
    A = repmat("",max,n);
    for i=1:max
        comb = pad(dec2bin(i),pad_size,'left','0');
        for j=1:n
            if(comb(j) == '1')
                A(i,j) = vars(1,j);
            else
                A(i,j) = "na";
            end
        end
    end
end
