function goToCalculations = reviewData(data)

% Mostra as variáveis introduzidas e dá
% a opção de continuar ou recomeçar.

clc
drawState(data.state);
printf('Módulo de Young:       %d MPa \n', data.ymodul )
printf('Área da secção reta:   %d m²  \n', data.area   )
printf('Comprimento da barra:  %d m   \n', data.comp   )
if data.isMola1
	printf('Constante k1:          %d \n', data.k1 )
	if data.isMola2
		printf('Constante k2:          %d \n', data.k2 )
	end
end
try % Tenho quase a certeza que não devo fazer isto mas é meia
	if data.isForce         % noite e já não consigo pensar...
		printf('Força F:               %d(N) \n', data.force )
	end
end
printf('Divisões para cálculo: %d \n', data.n )
% todo : disp(data.cargaAxial)
a = input('Deseja proceguir para os cálculos? [Y/n] ', 's');
if a == 'Y' || a == 'y' || size(a) == 0
	goToCalculations = true;
else
	goToCalculations = false;
end
