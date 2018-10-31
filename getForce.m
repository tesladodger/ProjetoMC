function force = getForce(message)

% Esta função é utilizada para recolher a força axial e, se
% existir, a força aplicada na extremidade da barra. Não é 
% utilizada a função getInput porque o valor pode ser
% negativo.


clc
printf(message)
badInput = true;
while badInput
	try
		force = input('==> ');
	catch error
		clc
		printf(message)
		printError(0);
		continue
	end
	if size(force) == 0
		clc
		printf(message)
		printError(0);
		continue
	else
		badInput = false;
		break;
	end
end
