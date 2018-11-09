N = 1000;
reverseStr = '';
for i = 1:N
    msg = sprintf('Processed %d/%d', i, N);
    fprintf([reverseStr, msg]);
    reverseStr = repmat(sprintf('\b'), 1, length(msg));
end

% Não está em uso! Pode dar jeito quando estivermos a fazer 
% cálculos com muitos pontos, fornecendo feedback visual.
