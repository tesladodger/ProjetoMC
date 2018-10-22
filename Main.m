% Projeto de MC
% Este programa calcula o deslocamento axial de uma barra
% sujeita a variadas forças (escolhidas pelo utilizador),
% e sobre apoios rigidos ou molas.

% Autores:
% André Martins, 87149
% Francisco Graça, 90249
% Inês Véstia, 87209
% Instituto Superior Técnico, 2018

clear
clc
repeat = true;
erro_in = false;
while repeat 

	printf('  EQUILIBRIO ESTATICO DE BARRAS \n ')
	printf('\n1 - Introduza os dados da barra\n')
	printf('2 - Barras conhecidas\n')
	printf('0 - Terminar\n')
	if erro_in
		printf('Erro de input\n')
		erro_in = false;
	end
	a = input('==> ', 's');
	
	a = str2num(a);

	if a == 1
		[area, comp, mola1, mola2, k1, k2, forc, n] = gatherer;
	elseif a == 2
		printf('Opcao 2\n')
	elseif a == 0
		printf('A sair...\n')
		repeat = false;
		break;
	else
		erro_in = true;
		clc
	end
end

