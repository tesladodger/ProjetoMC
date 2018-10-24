function gatherer

acceptZero = false;

clc
printf('Area da secção reta:\n')
area = input_tool(acceptZero);

clc
printf('Comprimento da barra:\n')
comp = input_tool(acceptZero);

clc
isMola1 = input('O primeiro apoio é uma mola? [Y/n]: ', 's');
if isMola1 == 'y' || isMola1 == 'Y' || size(isMola1) == 0
	isMola1 = true;
	printf('Constante da mola:\n')
	k1 = input_tool(acceptZero);
end

clc
isMola2 = input('O segundo apoio é uma mola? [Y/n]: ', 's');
if isMola2 == 'y' || isMola2 == 'Y' || size(isMola2) == 0
	isMola2 = true;
	printf('Constante da mola:\n')
	k2 = input_tool(acceptZero);
end


Force = force_gatherer(comp);


clc
printf('Número de divisões (malha) que deseja para o cálculo\n')
printf('(O valor será arredondado ao inteiro mais próximo)\n')
n = input_tool(acceptZero);  % = false
n = uint32(n)

