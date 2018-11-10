function [fun, str] = getCustomFunc();

badInput = false;
while true
	clc
	printf('Introduza a função da carga axial \n(Ex.: @(x) sin(x)\n')
	
	if badInput
		printError(0);
		badInput = false;
	end

	str = input('==> ', 's');

	try
		fun = str2func(str);
	catch error
		badInput = true;
		continue;
	end
	try
		% A função pode ser válida e não ter significado lógico
		% Deste modo, é testada com alguns valores:
		y = fun(1);
		y = fun(0);
		y = fun(pi);
	catch error
		badInput = true;
		continue
	end
	break;
end

expression = '@.*?\)'  % regular expression breakdown:
% @  -> primeiro caracter a procurar;
% .  -> iguala qualquer caracter na linha;
% *  -> iguala 0 ou mais do token anterior;
% ?  -> torna o quantificador preguiçoso, igualando o menor número
%	    possível de caracteres;
% \) -> último caracter (tem de ser escapado);
str = regexprep(str,expression,'');  % substituir o resultado
									 % da regex por ''
str = strtrim(str);                  % eliminar espaços iniciais
