function someVar = getInput(message, state, canBeNegative)

% (Quase) todos os inputs são tratados por 
% esta função. Aceita valores positivos ou
% negativos, conforme necessário.

clc
drawState(state);
printf(message);
badInput = true;
while badInput
	try
		someVar = input('==> ');
	catch   error
		clc
		drawState(state);
		printf(message);
		printError(0);
		continue
	end
	if      size(someVar) == 0
		clc
		drawState(state);
		printf(message);
		printError(0);
		continue
	elseif  someVar < 0 && !canBeNegative
		clc
		drawState(state);
		printf(message);
		printError(1);
		continue
	elseif  someVar == 0 && !canBeNegative
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
