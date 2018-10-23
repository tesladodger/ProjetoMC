function someVar = input_tool(acceptZero)

%(Quase) todos os inputs sao tratados por esta funcao
%Evita repetir codigo
%Testa se sao numeros e maiores que zero

ercode = 0;
badInput = true;
while badInput
	try
		someVar = input('==> ');
	catch error
		errr(ercode);
		continue
	end
	if someVar < 0
		ercode = 1;
		errr(ercode);
		continue
	elseif !acceptZero && someVar == 0
		ercode = 2;
		errr(ercode);
		continue
	else
		badInput = false;
		break;
	end
end
