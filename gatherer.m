function gatherer



printf('\nArea da seccao reta:\n')
area = input_tool;

printf('\nComprimento da barra:\n')
comp = input_tool;

isMola1 = input('O primeiro apoio é uma mola? (Y,n): ', 's');
if isMola1 == 'y' || isMola1 == 'Y'
	isMola1 = true;
	printf('\nConstante da mola:\n')
	k1 = input_tool;
end

isMola2 = input('O segundo apoio é uma mola? (Y,n): ', 's');
if isMola2 == 'y' || isMola2 == 'Y'
	isMola2 = true;
	printf('\nConstante da mola:\n')
	k2 = input_tool;
end

force = 0;
n = 0;
