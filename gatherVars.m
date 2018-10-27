function gatherVars()

% Recolhe as variáveis necessárias para o posterior cálculo.

acceptZero = false;

message = ('Módulo de Young do material (MPa):\n');
ymodul  = getInput(acceptZero, message);
message = ('Área da secção reta (m^2):\n');
area    = getInput(acceptZero, message);
message = ('Comprimento da barra (m):\n');
comp    = getInput(acceptZero, message);

clc
isMola1 = input('O primeiro apoio é uma mola? [Y/n]: ', 's');
if isMola1 == 'y' || isMola1 == 'Y' || size(isMola1) == 0
	isMola1 = true;
	message = ('Constante da mola:\n');
	k1      = getInput(acceptZero, message);
end

clc
isMola2 = input('O segundo apoio é uma mola? [Y/n]: ', 's');
if isMola2 == 'y' || isMola2 == 'Y' || size(isMola2) == 0
	isMola2 = true;
	message = ('Constante da mola:\n');
	k2      = getInput(acceptZero, message);
end

Force = getForces(comp);

clc
message = ('Número de divisões (malha) que deseja para o cálculo\n(O valor será arredondado ao inteiro mais próximo)\n')
n = getInput(acceptZero, message);
n = uint32(n);
if !( n & 1 )
	n += 1;
end
