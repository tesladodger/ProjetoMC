function printError(erCode)

%Para evitar escrever os erros para todos os inputs
%Torna o codigo muito mais simples e limpo

if erCode == 0
	printf('Erro: Input inválido!\n')
elseif erCode == 1
	printf('Erro: Valor deve ser positivo\n')
elseif erCode == 2
	printf('Erro: Valor não pode ser nulo\n')
end
