function goToCalculations = reviewData(data)

% Mostra ao utilizador as variáveis introduzidas e dá a opção de continuar ou
% recomeçar (regressar ao Main).
% Argumentos de entrada: variáveis presentes em data;
% Argumentos de saída: boolean -> goToCalculations;


clc
drawState(data.state);
printf('Módulo de Young:       %d GPa \n', (data.ymodul * (10.^(-9)))  )
printf('Área da secção reta:   %d m²  \n', data.area    )
printf('Comprimento da barra:  %d m   \n', data.comp    )
printf('Função da carga axial: %s     \n', data.funcstr )
if data.state == 1
    printf('Constante k:           %d N/m \n', data.k )
end
if data.state == 2 || data.state == 3
    printf('Força F:               %d N \n', data.force )
end
printf('Função da carga axial: %s     \n', data.funcstr )
if !(data.option == 3)
    printf('Divisões para cálculo: %d \n', data.n )
    printf('Número de pontos (df): %d \n', data.pontos )
end

a = input('Deseja proceguir para os cálculos? [Y/n] ', 's');
if a == 'Y' || a == 'y' || size(a) == 0
    goToCalculations = true;
else
    goToCalculations = false;
end
