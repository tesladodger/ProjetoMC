function gatherVars(useCustomFunc)

% Recolhe as variáveis necessárias para o posterior cálculo.
% Todas estas variáveis estão sob a classe data.
% Chama a função que resolve a equação diferencial pelo
% método de diferenças finitas (calculate).
% Recebe do Main o boolean useCustomFunc.
% Não retorna nenhuma variável ao Main.
% TO DO:
% - Decidir se Enter significa sim ou não;


data.state = 403;  % data.state não é acedido até se obter a carga axial
% Ver função drawState

message         = ('Módulo de Young do material (MPa):\n');
data.ymodul     = getInput(message, data.state, 0);
message         = ('Área da secção reta (m^2):\n');
data.area       = getInput(message, data.state, 0);
message         = ('Comprimento da barra (m):\n');
data.comp       = getInput(message, data.state, 0);
if useCustomFunc
	[data.cargaAxial, data.funcstr] = getCustomFunc();
else
	badInput = false;
	while true
		clc
		printf('  Qual a função que representa a carga axial distribuída?\n')
		printf('1 - Polinómio (grau 6)\n')
		printf('2 - sen(πx/L) \n')
		printf('3 - cos(πx/L) \n')
		printf('4 - exp(x/l)  \n')
		if badInput
			printError(0);
			badInput = false;
		end
		f = input('==>  ', 's');
		if f == '1'
			[data.cargaAxial, data.funcstr] = getPolinomio();
			break
		elseif f == '2'
			data.funcstr    = ('sen(πx/L)');
			data.cargaAxial = @(x,L) sin(pi*x/L);
			break
		elseif f == '3'
			data.funcstr    = ('cos(πx/L)');
			data.cargaAxial = @(x,L) cos(pi*x/L);
			break
		elseif f == '4'
			data.funcstr    = ('exp(x/l)');
			data.cargaAxial = @(x,L) exp(x/L);
			break
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
	data.isMola = true;
	message = ('Constante da mola:\n');
	data.k = getInput(message, data.state, 0);
else
	data.isMola = false;
end

if !data.isMola
	clc
	drawState(data.state);
	c = input('Existe um força aplicada na extremidade? [Y/n] ', 's');
	if c == 'y' || c == 'Y' || size(c) == 0
		data.isForce = true;
		message    = ('Qual o valor da força (N)?\n');
		data.force = getInput(message, data.state, 1);
		if data.force >= 0
			data.state += 2;
		else
			data.state += 3;
		end
	else
		data.isForce = false;  % Apenas necessário para condição seguinte
	end
end

if !data.isMola && !data.isForce
	clc
	drawState(data.state);
	d = input('Deseja encastrar a barra entre duas paredes? [Y/n] ', 's');
	if d == 'y' || d == 'Y' || size(d) == 0
		data.isWall = true;
		data.state += 4;
	end
end

clc
part1   = ('Número de pontos para o cálculo (maior ou igual a 3):\n');
part2   = ('(O valor será arredondado ao inteiro ímpar mais próximo)\n');
message = strcat(part1, part2);
n       = getInput(message, data.state, 0);
data.n  = uint32(n);
if (data.n < 3) data.n = 3; end
if !(mod(data.n, 2)) % Se não for ímpar
	data.n += 1;
end

goToCalculations = reviewData(data);
if goToCalculations
	calculate(data);
else
	return;
end
