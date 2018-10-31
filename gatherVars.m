function gatherVars()

% Recolhe as variáveis necessárias para o posterior cálculo.
% Chama a função que efetua os cálculos, evitando passar variáveis
% para o Main
% TO DO:
% - Decidir se Enter significa sim ou não;

acceptZero = false;
state = 401;  % Estado não existe até perguntar a carga axial

message     = ('Módulo de Young do material (MPa):\n');
ymodul      = getInput(acceptZero, message, state);
message     = ('Área da secção reta (m^2):\n');
area        = getInput(acceptZero, message, state);
message     = ('Comprimento da barra (m):\n');
comp        = getInput(acceptZero, message, state);
message     = ('Carga axial distribuída (N/m):\n')
cargaAxial  = getForce(message, state);

if cargaAxial >= 0
	state = 0;
else
	state = 1;
end

clc
drawState(state);
a = input('Existe uma mola na extremidade direita da barra? [Y/n]: ', 's');
if a == 'y' || a == 'Y' || size(a) == 0
	state += 2; 
	isMola1 = true;
	message = ('Constante da mola:\n');
	k1      = getInput(acceptZero, message, state);
else
	isMola1 = false;
end

if isMola1
	clc
	drawState(state);
	b = input('Deseja substituir a parede por uma segunda mola? [Y/n]: ', 's');
	if b == 'y' || b == 'Y' || size(b) == 0
		state = 4;
		isMola2 = true;
		message = ('Constante da mola:\n');
		k2      = getInput(acceptZero, message, state);
	else
		isMola = false;
	end
end

if !isMola1
	clc
	drawState(state);
	c = input('Existe um força aplicada na extremidade? [Y/n]: ', 's');
	if c == 'y' || c == 'Y' || size(c) == 0
		isForce = true;
		message = ('Qual o valor da força?\n');
		force   = getForce(message, state);
		if force >= 0
			state += 5;
		else
			state += 7;
		end
	end
else
	isForce = false;
end


clc
part1 = ('Número de divisões (malha) que deseja para o cálculo\n')
part2 = ('(O valor será arredondado ao inteiro mais próximo)\n')
message = strcat(part1, part2);
n = getInput(acceptZero, message, state);
n = uint32(n);   % Se utilizador inserir um número entre 0 e 0.5
if n == 0        % o valor é arredondado a 0. Como nós não queremos
	n += 1;  % isso, somamos 1.
end
