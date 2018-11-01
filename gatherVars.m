function gatherVars()

% Recolhe as variáveis necessárias para o posterior cálculo.
% Chama a função que efetua os cálculos, evitando passar variáveis
% para o Main
% TO DO:
% - Decidir se Enter significa sim ou não;

acceptZero = false;
state = 401;  % Estado não existe até perguntar a carga axial

message         = ('Módulo de Young do material (MPa):\n');
data.ymodul     = getInput(acceptZero, message, state);
message         = ('Área da secção reta (m^2):\n');
data.area       = getInput(acceptZero, message, state);
message         = ('Comprimento da barra (m):\n');
data.comp       = getInput(acceptZero, message, state);
message         = ('Carga axial distribuída (N/m):\n')
data.cargaAxial = getForce(message, state);

if data.cargaAxial >= 0
	state = 0;
else
	state = 1;
end

clc
drawState(state);
a = input('Existe uma mola na extremidade direita da barra? [Y/n]: ', 's');
if a == 'y' || a == 'Y' || size(a) == 0
	state += 2; 
	data.isMola1 = true;
	message = ('Constante da mola:\n');
	data.k1 = getInput(acceptZero, message, state);
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
		data.k2 = getInput(acceptZero, message, state);
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
		message    = ('Qual o valor da força?\n');
		data.force = getForce(message, state);
		if data.force >= 0
			state += 5;
		else
			state += 7;
		end
	end
else
	data.isForce = false;
end


clc
part1 = ('Número de divisões (malha) que deseja para o cálculo\n');
part2 = ('(O valor será arredondado ao inteiro mais próximo)\n');
message = strcat(part1, part2);
n      = getInput(acceptZero, message, state);
data.n = uint32(n);   % Se utilizador inserir um número entre 0 e 0.5
if data.n == 0        % o valor é arredondado a 0. Como nós não queremos
	data.n += 1;  % isso, somamos 1.
end
disp(data)
pause
