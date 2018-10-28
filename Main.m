% Projeto de MC
% Este programa calcula o deslocamento axial de uma barra
% sujeita a variadas forças (escolhidas pelo utilizador),
% e sobre apoios rígidos ou molas.

% Autores:
% André Martins, 87149
% Francisco Graça, 90249
% Inês Véstia, 87209
% Instituto Superior Técnico, 2018

clear
repeat = true;
badInput = false;
while repeat 
	clc
	printf('  EQUILÍBRIO ESTÁTICO DE BARRAS \n ')
	printf('\n1 - Introduza os dados da barra\n')
	printf('2 - Barras conhecidas\n')
	printf('0 - Terminar\n')
	if badInput
		printf('Erro de input\n')
		badInput = false;
	end
	a = input('==> ', 's');
	
	a = str2num(a);

	if a == 1
		gatherVars();
	elseif a == 2
		printf('Opcao 2\n')
	elseif a == 0
		printf('A sair...\n')
		repeat = false;
		clear;
		break;
	else
		badInput = true;
		clc
	end
end

