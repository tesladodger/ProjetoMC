function [fun, str] = getCustomFunc();

% Pede input da função que representa a distribuição do esforço axial.
% Não necessita de argumentos de entrada.
% Tem como argumentos de saída a function handle 'fun' e a string
% que representa essa função (ver reviewData).

badInput = false;
while true
	clc
	printf('Introduza a função da carga axial \n')
	printf('Ex.: @(x) sin(pi*x/L)\n')
	
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

expression = '@.*?\)'  
% regular expression breakdown:
% @  -> primeiro caracter a procurar;
% .  -> iguala qualquer caracter;
% *  -> quantificador: iguala 0 ou mais igualdades do token anterior;
% ?  -> torna o quantificador preguiçoso, igualando o menor número possível de
%       caracteres;
% \) -> último caracter (tem de ser escapado);

str = regexprep(str,expression,'');  % substituir o resultado

str = strtrim(str);  % eliminar espaços iniciais
