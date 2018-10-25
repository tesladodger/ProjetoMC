function gatherVars()

acceptZero = false;

message = ('Módulo de Young do material (MPa):\n');
ymodul = getVar(acceptZero, message);

message = ('Área da secção reta (m^2):\n');
area = getVar(acceptZero, message);

message = ('Comprimento da barra (m):\n');
comp = getVar(acceptZero, message);

clc
isMola1 = input('O primeiro apoio é uma mola? [Y/n]: ', 's');
if isMola1 == 'y' || isMola1 == 'Y' || size(isMola1) == 0
	isMola1 = true;
	message = ('Constante da mola:\n');
	k1 = getVar(acceptZero, message);
end

clc
isMola2 = input('O segundo apoio é uma mola? [Y/n]: ', 's');
if isMola2 == 'y' || isMola2 == 'Y' || size(isMola2) == 0
	isMola2 = true;
	message = ('Constante da mola:\n');
	k2 = getVar(acceptZero, message);
end

Force = getForces(comp);

clc
message = 'Número de divisões (malha) que deseja para o cálculo\n(O valor será arredondado ao inteiro mais próximo)\n'
n = getVar(acceptZero, message);
n = uint32(n);
