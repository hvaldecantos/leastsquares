function Z = expand(fs, X)
    [Mfs Nfs] = size(fs);
    [Mx Nx] = size(X);
    
    Z = zeros(Nfs, Mx);
 
    for i=1:length(fs)
        f = fs{i}{1}; % function
        k = fs{i}{2}; % index to know what data to apply
        
        Z(i,:) = f(X(:,k));
    end
end
%{
function Z = expand(fs, x)
% This function expand X into Z
  [Mfs Nfs] = size(fs);
  [Mx Nx] = size(x);
  
  Z = zeros(Nfs, Mx);
 
  for i=1:Nfs
    Z(i,:) = fs{i}(x);
  end
end
%}