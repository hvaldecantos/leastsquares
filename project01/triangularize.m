function [A b] = triangularize(A, b)
  [Ma Na] = size(A);
  [Mb Nb] = size(b);

  for i=1:Ma
    for j=i+1:Ma
      c = -A(j,i)/A(i,i);
      for k=1:Na
        A(j,k) = A(j,k) + c * A(i,k);
      end
      b(j,1) = b(j,1) + c * b(i,1);
    end
  end  
end

