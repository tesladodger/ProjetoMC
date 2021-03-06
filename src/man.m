function man()

% Manual do programa

clc
printf('                          MANUAL \n\n')



printf('Este programa calcula o deslocamento de cada ponto ao longo de uma barra,\n')
printf('sujeita a uma carga axial distribuída. As características da barra podem ser\n')
printf('personalizadas ou podem ser usados os valores predefinidos.\n\n')

printf('A barra pode também estar sujeita a uma força ou à ação de uma mola na\n')
printf('extremidade.\n\n')

printf('A primeira opção do menu permite introduzir uma expressão qualquer para\n')
printf('representar a carga axial.\n\n')

printf('A segunda opção permite calcular o deslocamento para uma função de carga  axial\n')
printf('conhecida. Deste modo, é também calculado o erro entre o método de diferenças\n')
printf('finitas e a expresão analítica.\n\n')

printf('A terceira opção realiza os cálculos para vários números de nós, tanto para\n')
printf('diferenças finitas de segundo como de quarto grau, apresentando o erro em\n')
printf('função do espaçamento (em escala logarítmica).\n\n')

printf('...')
pause
