function someVar = getInput(acceptZero, message, state)

% (Quase) todos os inputs são tratados por esta função.
% Evita repetir código.
% Testa se são números e maiores ou iguais a zero.

clc
drawState(state)
printf(message)
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
	if size(someVar) == 0
		clc
		drawState(state);
		printf(message);
		printError(0);
		continue
	elseif someVar < 0
		clc
		drawState(state);
		printf(message);
		printError(1);
		continue
	elseif !acceptZero && someVar == 0
		clc
		drawState(state);
		printf(message);
		printError(2);
		continue
	else
		badInput = false;
		break;
	end
end 
