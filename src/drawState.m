function drawState(state)

% O estado (state) da barra só pode ser 1 de 5 possíveis em cada momento,
% permitindo-nos desenhá-lo no terminal, com o mínimo de variáveis. Isto ajuda
% o utilizador a perceber se está a introduzir corretamente as caracterís-
% ticas do problema (uma imagem ASCII vale mais que 1000 caracteres).
% Nota: sim, ∫∫∫∫∫∫∫∫∫∫ é uma mola!


if state == 403 % Estado ainda não interessa
    return
elseif state == 0
    printf('/|                         |\\\n')
    printf('/|_________________________|\\\n')
    printf('/|           f(x)          |\\\n')
    printf('/| ->  ->  ->  ->  ->  ->  |\\\n')
    printf('/|_________________________|\\\n')
    printf('/|                         |\\\n')
    printf('/|<--------- L ----------->|\\\n\n')
elseif state == 1
    printf('/|\n')
    printf('/|_________________________\n')
    printf('/|           f(x)          |    k\n')
    printf('/| ->  ->  ->  ->  ->  ->  |∫∫∫∫∫∫∫∫∫∫\n')
    printf('/|_________________________|\n')
    printf('/|\n')
    printf('/|<--------- L ----------->\n\n')
elseif state == 2
    printf('/|\n')
    printf('/|_________________________\n')
    printf('/|           f(x)          |    F\n')
    printf('/| ->  ->  ->  ->  ->  ->  |=======>\n')
    printf('/|_________________________|\n')
    printf('/|\n')
    printf('/|<--------- L ----------->\n\n')
elseif state == 3
    printf('/|\n')
    printf('/|_________________________\n')
    printf('/|           f(x)          |    F\n')
    printf('/| ->  ->  ->  ->  ->  ->  |<=======\n')
    printf('/|_________________________|\n')
    printf('/|\n')
    printf('/|<--------- L ----------->\n\n')
elseif state == 4
    printf('/|\n')
    printf('/|_________________________\n')
    printf('/|           f(x)          |\n')
    printf('/| ->  ->  ->  ->  ->  ->  |\n')
    printf('/|_________________________|\n')
    printf('/|\n')
    printf('/|<--------- L ----------->\n\n')
end
