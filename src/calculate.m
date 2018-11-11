function calculate(data)


n = double(data.n);
h = data.comp / n;
f = data.cargaAxial;
E = data.ymodul;
L = data.comp;
A = data.area;
printf('A criar a matrix de coeficientes...\n')
reverseStr  = '';
matrix      = zeros(n,n);
matrix(1,1) = 1;
for i = 2 : 1 : n-1
	matrix(i,i)   = -2;
	matrix(i,i+1) =  1;
	matrix(i,i-1) =  1;
	
	msg = sprintf('Processado %d/%d', i+1, n);
	printf([reverseStr, msg])
	reverseStr = repmat(sprintf('\b'), 1, length(msg));
end
matrix(n,n) = 1;

printf('\nA inverter a matrix...\n')
invMatrix = inv(matrix);

format short % Demora demasiado tempo em long...
printf('A calcular o deslocamento...\n')
u = zeros(2,n);
ponto = 0;
for i = 1 : 1 : n
	u(1,i) = ponto;

	for j = 1 : 1 : n
		x = h*(j-1); % É por isto que indices começam do zero!!!
		u(2,i) = u(2,i) + ( invMatrix(i,j) * ( -1*(h.^2) * f(x,L) / ( E * A ) ) );

		msg = sprintf('Processado %d/%d', (i*(n-1))+j, n*n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	end
	ponto += h;
end

printf('\nA criar o gráfico...')
for k = 1 : 1 : n
	X(k) = u(1,k);
	Y(k) = u(2,k);
end
scatter(X,Y)
pause
format long
