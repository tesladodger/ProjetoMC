function errr(ercode)

%Para evitar escrever os erros para todos os inputs
%Torna o codigo muito mais simples e limpo

if ercode == 0
	printf('\nErro: Input invalido!\n')
elseif ercode == 1
	printf('\nErro: Valor deve ser positivo\n')
elseif ercode == 2
	printf('\nErro: Valor não pode ser nulo\n')
end
