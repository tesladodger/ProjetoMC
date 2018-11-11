function calculate(data)

% Esta função efectua os cálculos do deslocamento, por diferenças finitas
% e, se a função não for genérica, calcula o valor real e o erro;
% Posteriormente, são desenhados os gráficos desejados.


function u = calcularDeslocamentoEntreParedes;
	u = zeros(2,n);
	ponto = 0;
	for i = 1 : 1 : n
		u(1,i) = ponto;

		for j = 2 : 1 : n-1
			x = h*(j-1); % É por isto que indices começam do zero!!!
			u(2,i) += ( invMatrix(i,j) * ( -1*(h.^2) * f(x,L) / ( E * A ) ) );
		end

		msg = sprintf('Processado: %d/%d', i, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));

		ponto += h;
	end
end

function u = calcularDeslocamentoComForca;
	u = zeros(2,n);
	ponto = 0;
	for i = 1 : 1 : n
		u(1,i) = ponto;

		for j = 2 : 1 : n-1
			x = h*(j-1); % É por isto que indices começam do zero!!!
			u(2,i) += ( invMatrix(i,j) * ( -1*(h.^2) * f(x,L) / ( E * A ) ) );

		end
		u(2,i) += ( invMatrix(i,n) * ( h * F * L / ( A * E ) ) );

		msg = sprintf('Processado: %d/%d', i, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	
		ponto += h;
	end
end


% ___________________________________________________________
n = double(data.n);
h = data.comp / n;
f = data.cargaAxial;
E = data.ymodul;
L = data.comp;
A = data.area;


printf('A criar a matriz dos coeficientes...\n')
reverseStr  = '';
matrix      = zeros(n,n);
matrix(1,1) = 1;
for i = 2 : 1 : n-1
	matrix(i,i)   = -2;
	matrix(i,i+1) =  1;
	matrix(i,i-1) =  1;
	
	msg = sprintf('Processado: %d/%d', i+1, n);
	printf([reverseStr, msg])
	reverseStr = repmat(sprintf('\b'), 1, length(msg));
end
if data.state >= 2
	F = data.force;
	matrix(n,n-1) = -1;
	matrix(n,n)   =  1;
else
	matrix(n,n) = 1;
end


printf('\nA inverter a matrix...\n')
invMatrix = inv(matrix);


printf('A calcular o deslocamento...\n')
if data.state == 0
	u = calcularDeslocamentoEntreParedes;
elseif data.state >= 2
	u = calcularDeslocamentoComForca;
end

if data.funcstr == 'sen(πx/L)'
	if data.state == 0
		data.deslAnalit = @(x,L,E,A) ( ( L.^2 * sin(pi*x/L) ) / ( pi.^2 * E * A ) );
	elseif data.state <= 2
		data.deslAnalit = @(x,L,E,A) (  ( ( L.^2 * sin(pi*x/L) ) / ( pi.^2 * E * A ) ) + ( x * F / ( A * E ) )  );
	end
end


printf('\nA criar o gráfico...')
for k = 1 : 1 : n
	X(k)  = u(1,k);
	DF(k) = u(2,k);                        % Diferenças finitas
	YA(k) = data.deslAnalit(u(1,k),L,E,A); % Analiticamente
end
figure
scatter(X,DF,'*')
hold on
scatter(X,YA)
title('Gráfico do deslocamento')
xlabel('x (m)')
ylabel('u(x) (m)')
legend('Diferenças finitas','Analiticamente')


pause


end % if you end a nested function you need to end the parent
