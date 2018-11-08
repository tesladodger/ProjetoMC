function gatherVars()

% Recolhe as variáveis necessárias para o posterior cálculo.
% Chama a função que resolve a equação diferencial pelo
% método de diferenças finitas.
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
badInput = false;
repeat = true;
while repeat
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
		data.cargaAxial = getPolinomio();
		break
	elseif f == '2'
		data.cargaAxial = @(x,L) sin(pi*x/L);
		break
	elseif f == '3'
		data.cargaAxial = @(x,L) cos(pi*x/L);
		break
	elseif f == '4'
		data.cargaAxial = @(x,L) exp(x/L);
		break
	else
		badInput = true;
	end
end

data.state = 0;

clc
drawState(data.state);
a = input('Existe uma mola na extremidade direita da barra? [Y/n] ', 's');
if a == 'y' || a == 'Y' || size(a) == 0
	data.state += 2; 
	data.isMola1 = true;
	message = ('Constante da mola k1:\n');
	data.k1 = getInput(message, data.state, 0);
else
	data.isMola1 = false;
end

if data.isMola1
	clc
	drawState(data.state);
	b = input('Deseja substituir a parede por uma segunda mola? [Y/n] ', 's');
	if b == 'y' || b == 'Y' || size(b) == 0
		data.state = 4;
		data.isMola2 = true;
		message = ('Constante da mola k2:\n');
		data.k2 = getInput(message, data.state, 0);
	else
		data.isMola2 = false;
	end
end

if !data.isMola1
	clc
	drawState(data.state);
	c = input('Existe um força aplicada na extremidade? [Y/n] ', 's');
	if c == 'y' || c == 'Y' || size(c) == 0
		data.isForce = true;
		message    = ('Qual o valor da força (N)?\n');
		data.force = getInput(message, data.state, 1);
		if data.force >= 0
			data.state += 5;
		else
			data.state += 7;
		end
	else
		data.isForce = false;  % Apenas necessário para condição seguinte
	end
end

if !data.isMola1 && !data.isForce
	clc
	drawState(data.state);
	d = input('Deseja encastrar a barra entre duas paredes? [Y/n] ', 's');
	if d == 'y' || d == 'Y' || size(d) == 0
		data.isWall = true;
		data.state += 9;
	end
end

clc
part1   = ('Número de divisões (malha) que deseja para o cálculo\n');
part2   = ('(O valor será arredondado ao inteiro ímpar mais próximo)\n');
message = strcat(part1, part2);
n       = getInput(message, data.state, 0);
data.n  = uint32(n);  
if !(mod(data.n, 2)) 
	data.n += 1;
end

goToCalculations = reviewData(data);
if goToCalculations
	calculate(data);
else
	return;
end
