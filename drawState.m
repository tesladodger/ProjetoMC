function drawState(state)

% O estado (state) da barra só pode ser 1 de 9 possíveis
% em cada momento, permitindo-nos desenha-lo no terminal,
% com o mínimo de variáveis. Isto ajuda o utilizador a 
% perceber se está a introduzir corretamente as caracterís-
% ticas do problema.
% Nota: sim, ∫∫∫∫∫∫∫∫∫∫ é uma mola!


if state == 401 % Estado ainda não interessa
	return
elseif  state == 0
	printf('/|\n')
	printf('/|_________________________\n')
	printf('/|           a             |\n')
	printf('/| ->  ->  ->  ->  ->  ->  |\n')
	printf('/|_________________________|\n')
	printf('/|\n')
	printf('/|<--------- L ------------>\n\n')
elseif  state == 1
	printf('/|\n')
	printf('/|_________________________\n')
	printf('/|           a             |\n')
	printf('/|  <-  <-  <-  <-  <-  <- |\n')
	printf('/|_________________________|\n')
	printf('/|\n')
	printf('/|<--------- L ------------>\n\n')
elseif  state == 2
	printf('/|\n')
	printf('/|_________________________\n')
	printf('/|            a            |    k1\n')
	printf('/| ->  ->  ->  ->  ->  ->  |∫∫∫∫∫∫∫∫∫∫\n')
	printf('/|_________________________|\n')
	printf('/|\n')
	printf('/|<--------- L ------------>\n\n')
elseif  state == 3
	printf('/|\n')
	printf('/|_________________________\n')
	printf('/|             a           |    k2\n')
	printf('/|  <-  <-  <-  <-  <-  <- |∫∫∫∫∫∫∫∫∫∫\n')
	printf('/|_________________________|\n')
	printf('/|\n')
	printf('/|<--------- L ------------>\n\n')
elseif  state == 4
	printf('\n')
	printf('       _________________________\n')
	printf('  k2  |            a            |  k1\n')
	printf('∫∫∫∫∫∫| ->  ->  ->  ->  ->  ->  |∫∫∫∫∫∫\n')
	printf('      |_________________________|\n')
	printf('\n')
	printf('/|<--------- L ------------>\n\n')
elseif  state == 5
	printf('/|\n')
	printf('/|_________________________\n')
	printf('/|             a           |    F\n')
	printf('/| ->  ->  ->  ->  ->  ->  |=======>\n')
	printf('/|_________________________|\n')
	printf('/|\n')
	printf('/|<--------- L ------------>\n\n')
elseif  state == 6
	printf('/|\n')
	printf('/|_________________________\n')
	printf('/|             a           |    F\n')
	printf('/|  <-  <-  <-  <-  <-  <- |=======>\n')
	printf('/|_________________________|\n')
	printf('/|\n')
	printf('/|<--------- L ------------>\n\n')
elseif  state == 7
	printf('/|\n')
	printf('/|_________________________\n')
	printf('/|             a           |    F\n')
	printf('/| ->  ->  ->  ->  ->  ->  |<=======\n')
	printf('/|_________________________|\n')
	printf('/|\n')
	printf('/|<--------- L ------------>\n\n')
elseif  state == 8
	printf('/|\n')
	printf('/|_________________________\n')
	printf('/|             a           |    F\n')
	printf('/|  <-  <-  <-  <-  <-  <- |<=======\n')
	printf('/|_________________________|\n')
	printf('/|\n')
	printf('/|<--------- L ------------>\n\n')
end
