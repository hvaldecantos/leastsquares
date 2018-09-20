function [M R w] = least_squares(Z, y)
  [p N] = size(Z);

  M = zeros(size(Z,1));
  s = zeros(size(Z,1),1);

  M = Z*Z';
  s = Z*y;

  [Ap bp] = triangularize(M,s);
  w = back_substitute(Ap,bp);

  y_pred = w' * Z;
  R = norm(y - y_pred')^2;
end
