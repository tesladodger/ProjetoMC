function Force = getForces(comp)

noForceError = false;
biggerThanCompError = false;
acceptZero = true;
iterator = 1;
moreForces = true;
while moreForces

	clc
	printf('Forças aplicadas na barra:')
	
	if iterator > 1
		printf('\nPosição:  ')
		for i = 1 : 1 : (iterator - 1)
			s = num2str(Force(1,i));                     % Passo os valores para
			space = repmat(' ', 1, ( 7 - length(s) ) );  % strings para poder mostrá-los
			printf('%s%s', s, space)                     % com espaçamento uniforme.
		end						     % Se o valor tiver mais de 7
		printf('\nForça:    ')			             % caracteres, dá asneira.
		for i = 1 : 1 : (iterator - 1)
			s = num2str(Force(2,i));
			space = repmat(' ', 1, ( 7 - length(s) ) );
			printf('%s%s', s, space)
		end
	end



	if noForceError
		printf('\nErro: Tem de introduzir pelo menos uma força!')
		noForceError = false;
	end
	if biggerThanCompError
		printf('\nErro: Introduza um valor menor que o comprimento da barra!')
		biggerThanCompError = false;
	end



	disp('')
	b = input('=> Acrescentar força? [Y/n] ', 's');
	if b == 'Y' || b == 'y' || size(b) == 0
		message = 'Posição da força na barra (m):\n';
		temp = getVar(acceptZero, message);
		if temp <= comp
			Force(1, iterator) = temp;
		else 
			biggerThanCompError = true;
			continue
		end

		message = 'Valor da força (N):\n';
		% O módulo da força pode ser negativo, logo, de forma a não
		% sobrecomplicar a função getVar pede-se o seu valor 
		% diretamente
		clc
		printf(message)
		badInput = true;
		while badInput
			try
				temp = input('==> ');
			catch error
				clc
				printf(message)
				printError(0);
				continue
			end
			badInput = false;
		end
		Force(2, iterator) = temp;
		iterator += 1;

	elseif iterator == 1
		noForceError = true;
		continue
	else
		return;
	end
end
