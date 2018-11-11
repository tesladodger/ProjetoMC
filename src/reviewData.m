function goToCalculations = reviewData(data)

% Mostra ao utilizador as variáveis introduzidas e dá
% a opção de continuar ou recomeçar (regressar ao Main).
% Argumentos de entrada: variáveis presentes em data;
% Argumentos de saída: boolean -> goToCalculations;

clc
drawState(data.state);
printf('Módulo de Young:       %d GPa \n', data.ymodul/1000000000 )
printf('Área da secção reta:   %d m²  \n', data.area   )
printf('Comprimento da barra:  %d m   \n', data.comp   )
if data.isMola
	printf('Constante k:           %d \n', data.k )
end
try % Tenho quase a certeza que não devo fazer isto mas é meia
	if data.isForce         % noite e já não consigo pensar...
		printf('Força F:               %d(N) \n', data.force )
	end
end
printf('Divisões para cálculo: %d \n', data.n )
printf('Função da carga axial: %s \n', data.funcstr)
printf('\n')
a = input('Deseja proceguir para os cálculos? [Y/n] ', 's');
if a == 'Y' || a == 'y' || size(a) == 0
	goToCalculations = true;
else
	goToCalculations = false;
end
