function someVar = getInput(message, state, canBeNegative)

% Todos os inputs numéricos são tratados por esta função. Aceita valores
% positivos e negativos, conforme necessário.
% Argumentos de entrada: 
%   string  -> message       " mensagem a mostrar ao utilizador
%   int     -> state         " ver drawState
%   boolean -> canBeNegative " aceitar valores negativos ou não
% Argumentos de saída:
%   double  -> someVar       " variável pedida


clc
drawState(state);
printf(message);
badInput = true;
while badInput
    try
        someVar = input('==> ');
    catch error
        clc
        drawState(state);
        printf(message);
        printError(0);
        continue
    end
    if  size(someVar) == 0
        clc
        drawState(state);
        printf(message);
        printError(0);
        continue
    elseif someVar < 0 && !canBeNegative
        clc
        drawState(state);
        printf(message);
        printError(1);
        continue
    elseif someVar == 0 && !canBeNegative
        clc
        drawState(state);
        printf(message);
        printError(2);
        continue
    else
        badInput = false;
        return
    end
end
