function gatherVars()

acceptZero = false;

clc
printf('Módulo de Young do material (MPa):\n')
ymodul = getVar(acceptZero);

clc
printf('Área da secção reta (m^2):\n')
area = getVar(acceptZero);

clc
printf('Comprimento da barra (m):\n')
comp = getVar(acceptZero);

clc
isMola1 = input('O primeiro apoio é uma mola? [Y/n]: ', 's');
if isMola1 == 'y' || isMola1 == 'Y' || size(isMola1) == 0
	isMola1 = true;
	printf('Constante da mola:\n')
	k1 = getVar(acceptZero);
end

clc
isMola2 = input('O segundo apoio é uma mola? [Y/n]: ', 's');
if isMola2 == 'y' || isMola2 == 'Y' || size(isMola2) == 0
	isMola2 = true;
	printf('Constante da mola:\n')
	k2 = getVar(acceptZero);
end

Force = getForces(comp);

clc
printf('Número de divisões (malha) que deseja para o cálculo\n')
printf('(O valor será arredondado ao inteiro mais próximo)\n')
n = getVar(acceptZero);  % = false
n = uint32(n);

