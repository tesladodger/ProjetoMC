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
if data.pontos == 3
	matrix(1,1) = 1;
	for i = 2 : 1 : n-1
		matrix(i,i-1) =  1;
		matrix(i,i)   = -2;
		matrix(i,i+1) =  1;
		msg = sprintf('%d/%d', i+1, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	end
elseif data.state >= 2
		matrix(n,n-2) =  1;
		matrix(n,n-1) = -4;
		matrix(n,n)   =  3;
	if data.state == 1
		matrix(n,n-1) = -1;
		matrix(n,n)   = (-((h*k)/(E*A)));
	else
		matrix(n,n) = 1;
	end
elseif data.pontos == 5
	matrix(1,1) = 1/12;
	for i = 3 : 1 : n-2
		matrix(i,i-2) = -1/12;
		matrix(i,i-1) =   4/3;
		matrix(i,i)   =  -5/2;
		matrix(i,i+1) =   4/3;
		matrix(i,i+2) = -1/12;
		msg = sprintf('%d/%d', i+2, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	end
	matrix(2,1) = matrix(n-1,n)   = 11/12;
	matrix(2,2) = matrix(n-1,n-1) =  -5/3;
	matrix(2,3) = matrix(n-1,n-2) =   1/2;
	matrix(2,4) = matrix(n-1,n-3) =   1/3;
	matrix(2,5) = matrix(n-1,n-4) = -1/12;
	if data.state >= 2
		matrix(n,n-4) =  1/2;
		matrix(n,n-3) = -7/3;
		matrix(n,n-2) =    6;
		matrix(n,n-1) =   -8;
		matrix(n,n)   = 25/6;
	elseif data.state == 1
		matrix(n,n-4) =   6;
		matrix(n,n-3) = -32;
		matrix(n,n-2) =  72;
		matrix(n,n-1) = -96;
		matrix(n,n)   =  50-((h*K)/(E*A));
	elseif data.state == 0
		matrix(n,n) = 1/12;
	end
end



printf('\nA inverter a matrix...\n')
invMatrix = inv(matrix);
