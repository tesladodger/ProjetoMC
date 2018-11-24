% Projeto de MC / JF-17

% Este programa calcula o deslocamento axial de uma barra sujeita a uma carga
% axial. O utilizador pode também aplicar uma força ou uma mola na extremidade
% da barra, estando a outra extremidade encastrada.  Pode também suspender a
% barra entre duas molas.
% Consulte man.m para mais detalhes.

% Programado em GNU Octave (C) 4.4.1, para 'x86_64-pc-linux-gnu'

% Autores:         ID:
% André Martins    87149
% Francisco Graça  90249
% Inês Véstia      87209

% Instituto Superior Técnico, 2018



clear;
format long;
repeat   = true;
badInput = false;


while repeat
	clc
	printf('  EQUILÍBRIO ESTÁTICO DE BARRAS \n\n')
	printf('1 - Cálculo do deslocamento\n')
	printf('2 - Funções predefinidas\n')
	printf('3 - Testar o erro do programa\n')
	printf('4 - Manual\n')
	printf('0 - Terminar \n')
	
	if badInput
		printError(0);
		badInput = false;
	end
	
	a = input('==> ', 's');

	if a == '1'
		gatherVars(1);
	
	elseif a == '2'
		gatherVars(2);

	elseif a == '3'
		gatherVars(3);

	elseif a == '4'
		man();

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

