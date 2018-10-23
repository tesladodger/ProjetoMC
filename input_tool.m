function someVar = input_tool(acceptZero)

%(Quase) todos os inputs sao tratados por esta funcao
%Evita repetir codigo
%Testa se sao numeros e maiores que zero

badInput = true;
while badInput
	try
		someVar = input('==> ');
	catch error
		errr(0);
		continue
	end
	if size(someVar) == 0
		errr(0);
		continue
	elseif someVar < 0
		errr(1);
		continue
	elseif !acceptZero && someVar == 0
		errr(2);
		continue
	else
		badInput = false;
		break;
	end
end
