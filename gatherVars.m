function gatherVars()

% Recolhe as variáveis necessárias para o posterior cálculo.
% Chama a função que resolve a equação diferencial pelo
% método de diferenças finitas.
% TO DO:
% - Decidir se Enter significa sim ou não;


state = 403;  % state não é acedido até se obter a carga axial
% Ver função drawState

message         = ('Módulo de Young do material (MPa):\n');
data.ymodul     = getInput(message, state, 0);
message         = ('Área da secção reta (m^2):\n');
data.area       = getInput(message, state, 0);
message         = ('Comprimento da barra (m):\n');
data.comp       = getInput(message, state, 0);
message         = ('Carga axial distribuída (N/m):\n')
data.cargaAxial = getInput(message, state, 1);

if (data.cargaAxial >= 0) state = 0;
else state = 1;
end

clc
drawState(state);
a = input('Existe uma mola na extremidade direita da barra? [Y/n]: ', 's');
if a == 'y' || a == 'Y' || size(a) == 0
	state += 2; 
	data.isMola1 = true;
	message = ('Constante da mola:\n');
	data.k1 = getInput(message, state, 0);
else
	data.isMola1 = false;
end

if data.isMola1
	clc
	drawState(state);
	b = input('Deseja substituir a parede por uma segunda mola? [Y/n]: ', 's');
	if b == 'y' || b == 'Y' || size(b) == 0
		state = 4;
		data.isMola2 = true;
		message = ('Constante da mola:\n');
		data.k2 = getInput(message, state, 0);
	else
		data.isMola2 = false;
	end
end

if !data.isMola1
	clc
	drawState(state);
	c = input('Existe um força aplicada na extremidade? [Y/n]: ', 's');
	if c == 'y' || c == 'Y' || size(c) == 0
		data.isForce = true;
		message    = ('Qual o valor da força (N)?\n');
		data.force = getInput(message, state, 1);
		if data.force >= 0
			state += 5;
		else
			state += 7;
		end
	end
end


clc
part1   = ('Número de divisões (malha) que deseja para o cálculo\n');
part2   = ('(O valor será arredondado ao inteiro mais próximo)\n');
message = strcat(part1, part2);
n       = getInput(message, state, 0);
data.n  = uint32(n);   % Se utilizador inserir um número entre 0 e 0.5
if data.n == 0         % o valor é arredondado a 0. Como nós não queremos
	data.n += 1;   % isso, somamos 1.
end
disp(data)
pause
