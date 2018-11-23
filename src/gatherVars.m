function gatherVars(option)

% Recolhe as variáveis necessárias para o posterior cálculo.  Todas estas
% variáveis estão sob a classe data.  Chama a função que resolve a equação
% diferencial pelo método de diferenças finitas (calculate).  Recebe do Main
% a opção escolhida.  Não retorna nenhuma variável ao Main.  
% TO DO: - Decidir se
% Enter significa sim ou não;

data.option = option;
data.state  = 403;  % data.state não é acedido
                    % até se obter a carga axial
                    % (ver função drawState)

if true % option == 3
	clc
	drawState(0);
	printf('Módulo de Young:  200 GPa \n')
	printf('Área da secção:  0.05 m²  \n')
	printf('Comprimento:        5 m   \n')
	a = input('Deseja prosseguir com estes parametros? [Y/n] ', 's');
	if a == 'y' || a == 'Y' || size(a) == 0
		data.ymodul = 200 * (10.^9);
		data.area   = 0.05;
		data.comp   = 5;
		skip        = true;
	else
		skip = false;
	end
else
	skip = false;
end

if !skip
	message     = ('Módulo de Young do material (GPa):\n');
	data.ymodul = getInput(message, data.state, 0) * (10.^9);
	message     = ('Área da secção reta (m^2):\n');
	data.area   = getInput(message, data.state, 0);
	message     = ('Comprimento da barra (m): \n');
	data.comp   = getInput(message, data.state, 0);
end

if option == 1
	[data.cargaAxial, data.funcstr] = getCustomFunc();
elseif option == 2 || option == 3
	badInput = false;
	while true
		clc
		printf('  Qual a função que representa a carga axial distribuída?\n\n')
		printf('1 - polinómio (grau 6)\n')
		printf('2 - sen(πx/L)         \n')
		printf('3 - exp(x)            \n')
		printf('4 - 2x²+6             \n\n')
		if badInput
			printError(0);
			badInput = false;
		end
		f = input('==>  ', 's');
		if f == '1'
			[data.cargaAxial, data.funcstr, data.coef] = getPolinomio();
			break;
		elseif f == '2'
			data.funcstr    = ('sen(πx/L)');
			L = data.comp;
			data.cargaAxial = @(x) sin(pi*x/L);
			break;
		elseif f == '3'
			data.funcstr    = ('exp(x)');
			data.cargaAxial = @(x) exp(x);
			break;
		elseif f == '4'
			data.funcstr    = ('12x²+6');
			data.cargaAxial = @(x) (12*x.^2)+6;
			break;
		else
			badInput = true;
		end
	end
end

data.state = 0;

clc
drawState(data.state);
a = input('Existe uma mola na extremidade direita da barra? [Y/n] ', 's');
if a == 'y' || a == 'Y' || size(a) == 0
	data.state += 1; 
	message = ('Constante da mola (N/m):\n');
	data.k = getInput(message, data.state, 1); % MUDA PARA 0!!!
else
	clc
	drawState(data.state);
	c = input('Existe um força aplicada na extremidade? [Y/n] ', 's');
	if c == 'y' || c == 'Y' || size(c) == 0
		message      = ('Qual o valor da força (N)?\n');
		data.force   = getInput(message, data.state, 1);
		if     (data.force > 0)  data.state += 2;
		elseif (data.force < 0)  data.state += 3;
		else                     data.state += 4;
		end
	end
end


if !(option == 3)
	badInput = false;
	while true
		clc
		drawState(data.state)
		printf('Efectuar difenças finitas com 3 ou 5 pontos?\n')
		if badInput
			printError(0);
			badInput = false;
		end
		p = input('==> ', 's');
		if p == '3'
			data.pontos = 3;
			break;
		elseif p == '5'
			data.pontos = 5;
			break;
		else
			badInput = true;
		end
	end

	clc
	part1   = sprintf('Número de divisões para o cálculo (maior ou igual a %s)\n',p);
	part2   = ('(O valor será arredondado ao inteiro mais próximo)\n');
	message = strcat(part1,part2);
	n       = getInput(message, data.state, 0);
	data.n  = uint32(n);
	if p == '5' && data.n <5
		data.n = 5;
	elseif data.n < 3
		data.n = 3;
	end
end


goToCalculations = reviewData(data);
if goToCalculations
	calculate(data);
else
	return;
end
