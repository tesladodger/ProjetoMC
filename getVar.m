function someVar = getVar(acceptZero)

% (Quase) todos os inputs sao tratados por esta função
% Evita repetir código
% Testa se são números e maiores ou iguais a zero

badInput = true;
while badInput
	try
		someVar = input('==> ');
	catch error
		printError(0);
		continue
	end
	if size(someVar) == 0
		printError(0);
		continue
	elseif someVar < 0
		printError(1);
		continue
	elseif !acceptZero && someVar == 0
		printError(2);
		continue
	else
		badInput = false;
		break;
	end
end
