% Projeto de MC / JF-17

% Este programa calcula o deslocamento axial de uma barra
% sujeita a uma carga axial. O utilizador pode
% também aplicar uma força ou uma mola na extremidade da 
% barra, estando a outra extremidade encastrada.
% Pode também suspender a barra entre duas molas.

% Programado em GNU Octave (C) 4.4.1
% sob 'x86_64-pc-linux-gnu'

% Autores:         ID:
% André Martins    87149
% Francisco Graça  90249
% Inês Véstia      87209
% Instituto Superior Técnico, 2018



clear
format long;
repeat   = true;
badInput = false;


while repeat
	clc
	printf('  EQUILÍBRIO ESTÁTICO DE BARRAS \n\n')
	printf('1 - Introduza os dados da barra \n')
	printf('2 - Barras conhecidas \n')
	printf('0 - Terminar \n')
	
	if badInput
		printError(0);
		badInput = false;
	end
	
	a = input('==> ', 's');

	if a == '1'
		gatherVars();
	
	elseif a == '2'
		printf('Opção 2\n')
	
	elseif a == '0' || a == 'q'
		printf('A sair...\n')
		repeat = false;
		clear;
		break;
	
	else
		badInput = true;
		clc
	
	end
end

