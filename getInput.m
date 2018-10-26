function someVar = getInput(acceptZero, message)

% (Quase) todos os inputs sao tratados por esta função
% Evita repetir código
% Testa se são números e maiores ou iguais a zero

clc
printf(message)
badInput = true;
while badInput
	try
		someVar = input('==> ');
	catch error
		clc
		printf(message)
		printError(0);
		continue
	end
	if size(someVar) == 0
		clc
		printf(message)
		printError(0);
		continue
	elseif someVar < 0
		clc
		printf(message)
		printError(1);
		continue
	elseif !acceptZero && someVar == 0
		clc
		printf(message)
		printError(2);
		continue
	else
		badInput = false;
		break;
	end
end 
