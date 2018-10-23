function gatherer

acceptZero = false;

printf('\nArea da seccao reta:\n')
area = input_tool(acceptZero);

printf('\nComprimento da barra:\n')
comp = input_tool(acceptZero);

isMola1 = input('O primeiro apoio é uma mola? [Y/n]: ', 's');
if isMola1 == 'y' || isMola1 == 'Y' || size(isMola1) == 0
	isMola1 = true;
	printf('\nConstante da mola:\n')
	k1 = input_tool(acceptZero);
end

isMola2 = input('O segundo apoio é uma mola? [Y/n]: ', 's');
if isMola2 == 'y' || isMola2 == 'Y' || size(isMola2) == 0
	isMola2 = true;
	printf('\nConstante da mola:\n')
	k2 = input_tool(acceptZero);
end

Force = force_gatherer(comp);
disp(Force)

n = 0;
