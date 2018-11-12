function calculate(data)

% Esta função efectua os cálculos do deslocamento, por diferenças finitas
% e, se a função não for genérica, calcula o valor real e o erro;
% Posteriormente, são desenhados os gráficos desejados.


function u = calcEntreParedes;
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

function u = calcComForca;
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
n = double(data.n) ;
L = data.comp      ;
h = L / n          ;
f = data.cargaAxial;
E = data.ymodul    ;
A = data.area      ;



printf('A criar a matriz dos coeficientes...\n')
reverseStr  = '';
matrix      = zeros(n,n);
matrix(1,1) = 1;
if data.pontos == 3
	for i = 2 : 1 : n-1
		matrix(i,i)   = -2;
		matrix(i,i+1) =  1;
		matrix(i,i-1) =  1;

		msg = sprintf('Processado: %d/%d', i+1, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	end
	if data.state >= 2
		F             = data.force;
		matrix(n,n-1) = -1;
		matrix(n,n)   =  1;
	else
		matrix(n,n) = 1;
		F           = 0;
	end
end


printf('\nA inverter a matrix...\n')
invMatrix = inv(matrix);


printf('A calcular o deslocamento por diferenças finitas...\n')
if data.state == 0 && data.pontos == 3
	u = calcEntreParedes;
elseif data.state >= 2 && data.pontos == 3
	u = calcComForca;
end
printf('\n')


if data.option == 2
	printf('A calcular analiticamente...\n')
	if strcmp(data.funcstr,('sen(πx/L)'))
		if data.state == 0
			data.deslAnalit = @(x,L,E,A,F) (  ((L/pi).^2) * (sin(pi*x/L)) / (E*A)  );
		elseif data.state >= 2
			data.deslAnalit = @(x,L,E,A,F) (  (((L/pi).^2) * sin(pi*x/L) / (E*A)) + (F*x/(E*A))  );
		end
	elseif strcmp(data.funcstr,('exp(x)'))
		if data.state == 0
			data.deslAnalit = @(x,L,E,A,F) ( - ( exp(x) + (x/L)*(1-exp(L)) - 1 ) / (E*A) );
		elseif data.state >= 2
			data.deslAnalit = @(x,L,E,A,F) ( - ( exp(x) + (x/L)*(1-F*L-exp(L)) - 1 ) / (E*A) );
		end
	elseif strcmp(data.funcstr,'12x²+6')
		if data.state == 0
			data.deslAnalit = @(x,L,E,A,F) ( - ( (x.^4) + (3*x) - (x*(3+(L.^3))) ) / (E*A)  );
		elseif data.state >= 2
			data.deslAnalit = @(x,L,E,A,F) ( - (  (x.^4) + (3*x) - (F+(L.^3)+3)*x  ) / (E*A)  );
		end
	else  % Quando é um polinómio:
		coef = data.coef;
		for i = 7 : -1 : 1
			if !(coef(i) == 0)
				c(i) = coef(i)/(i*(i+1));
			else
				c(i) = 0;
			end
		end   % Cuidado, esparguete:
		iif = @(x) ((c(7)*x.^8)+(c(6)*x.^7)+(c(5)*x.^6)+(c(4)*x.^5)+(c(3)*x.^4)+(c(2)*x.^3)+(c(1)*x.^2));
		if data.state == 0
			data.deslAnalit = @(x,L,E,A,F) (- ( (iif(x) - (iif(L)*x/L)) / (E*A) ) );
		elseif data.state >= 2
			data.deslAnalit = @(x,L,E,A,F) (- (( iif(x) - F*x - (iif(L)*x/L) )/(E*A)) );
		end   % Fim da esparguete.
	end
	printf('A calcular o erro relativo...\n')
	for k = 1 : 1 : n
		erro(k) = abs( ( u(2,k) - data.deslAnalit(u(1,k),L,E,A,F) ) / data.deslAnalit(u(1,k),L,E,A,F) );
	end
end


printf('A criar o gráfico...\n')
for k = 1 : 1 : n
	X(k)  = u(1,k);
	DF(k) = u(2,k);  % Diferenças finitas
end
if data.option == 2
	for k = 1 : 1 : n
		YA(k) = data.deslAnalit(u(1,k),L,E,A,F);  % Analiticamente
	end
end
figure
if data.option == 1
	scatter(X,DF,'*')
	title('Gráfico do deslocamento')
	xlabel('x (m)')
	ylabel('u(x) (nm)')
elseif data.option == 2
	subplot(2,1,1);
	scatter(X,DF,'*')
	hold on
	scatter(X,YA)
	legend('Diferenças finitas','Analiticamente')
	title('Gráfico do deslocamento')
	xlabel('x (m)')
	ylabel('u(x) (nm)')

	subplot(2,1,2)
	scatter(X,erro)
	title('Erro relativo')
	xlabel('x (m)')
	ylabel('erro')
end


printf('\nPressione qualquer tecla para continuar...')
pause


end % if you end a nested function you need to end the parent
