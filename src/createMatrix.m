function invMatrix = createMatrix(data)

% Esta função gera a matriz dos coeficientes para o cálculo das diferenças
% finitas, para 3 e 5 pontos. Recebe as variáveis presentes em data e devolve a
% matriz já invertida. 



n = double(data.n);
L = data.comp;
h = L / (n - 1);
E = data.ymodul;
A = data.area;
if data.state >= 2
	F = data.force;
elseif data.state == 1
	k = data.k;
else
	F = 0;
	k = 0;
end


printf('\nA criar a matriz dos coeficientes...\n')
reverseStr  = '';
matrix      = zeros(n,n);
matrix(1,1) = 1;
if data.pontos == 3
	for i = 2 : 1 : n-1
		matrix(i,i)   = -2;
		matrix(i,i+1) =  1;
		matrix(i,i-1) =  1;
		msg = sprintf('%d/%d', i+1, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	end
	if data.state >= 2
		matrix(n,n-2) =  1;
		matrix(n,n-1) = -4;
		matrix(n,n)   =  3;
	elseif data.state == 1
		matrix(n,n-1) = -1;
		matrix(n,n)   = (1-((h*k)/(E*A)));
	else
		matrix(n,n) = 1;
	end
elseif data.pontos == 5
	for i = 3 : 1 : n-2
		matrix(i,i)   = 30;
		matrix(i,i+1) = 16;
		matrix(i,i+2) = -1;
		matrix(i,i-1) = 16;
		matrix(i,i-2) = -1;
		msg = sprintf('%d/%d', i+2, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	end
	matrix(2,1)     =  11;
	matrix(2,2)     = -20;
	matrix(2,3)     =   6;
	matrix(2,4)     =   4;
	matrix(2,5)     =  -1;
	matrix(n-1,n-4) =  -1;
	matrix(n-1,n-3) =   4;
	matrix(n-1,n-2) =   6;
	matrix(n-1,n-1) = -20;
	matrix(n-1,n)   =  11;
	if data.state >= 2
		matrix(n,n-4) =   6;
		matrix(n,n-3) = -32;
		matrix(n,n-2) =  72;
		matrix(n,n-1) = -96;
		matrix(n,n)   =  50;
	elseif data.state == 1
		matrix(n,n-4) =   6;
		matrix(n,n-3) = -32;
		matrix(n,n-2) =  72;
		matrix(n,n-1) = -96;
		matrix(n,n)   =  50-((h*K)/(E*A));
	elseif data.state == 0
		matrix(n,n) = 1;
	end
end


printf('\nA inverter a matrix...\n')
invMatrix = inv(matrix);
