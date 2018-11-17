function calculate(data)

% Esta função efectua os cálculos do deslocamento, por diferenças finitas e, se
% a função não for genérica, calcula o valor real e o erro; Posteriormente, são
% desenhados os gráficos desejados.  Cada estado tem duas funções, para 3 e 5
% pontos, porque é muito mais rápido do que condicionar as expressões dentro do
% loop.


function u = calcEntreParedes3();
	u = zeros(2,n);
	ponto = 0;
	for i = 1 : 1 : n
		u(1,i) = ponto;

		for j = 2 : 1 : n-1
			x = h*(j-1); % É por isto que indices começam do zero!!!
			u(2,i) += ( invMatrix(i,j) * ( -1*(h.^2) * f(x,L) / ( E * A ) ) );
		end

		msg = sprintf('%d/%d', i, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));

		ponto += h;
	end
end

function u = calcEntreParedes5();
	u = zeros(2,n);
	ponto = 0;
	for i = 1 : 1 : n
		u(1,i) = ponto;

		for j = 2 : 1 : n-1
			x = h*(j-1); % É por isto que indices começam do zero!!!
			u(2,i) += ( invMatrix(i,j) * ( -1*(h.^2) * f(x,L) / ( E * A ) ) );
		end

		msg = sprintf('%d/%d', i, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));

		ponto += h;
	end
end

function u = calcComMola3();
	u = zeros(2,n);
	ponto = 0;
	for i = 1 : 1 : n
		u(1,i) = ponto;

		for j = 2 : 1 : n-1
			x = h*(j-1); % É por isto que indices começam do zero!!!
			u(2,i) += ( invMatrix(i,j) * ( (-h * f(x,L)) / (E*A) ) );
		end

		msg = sprintf('%d/%d', i, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));

		ponto += h;
	end
end

function u = calcComMola5();
	u = zeros(2,n);
	ponto = 0;
	for i = 1 : 1 : n
		u(1,i) = ponto;

		for j = 2 : 1 : n-1
			x = h*(j-1); % É por isto que indices começam do zero!!!
			u(2,i) += ( invMatrix(i,j) * ( (-h * f(x,L)) / (E*A) ) );
		end

		msg = sprintf('%d/%d', i, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));

		ponto += h;
	end
end

function u = calcComForca3();
	u = zeros(2,n);
	ponto = 0;
	for i = 1 : 1 : n
		u(1,i) = ponto;

		for j = 2 : 1 : n-1
			x = h*(j-1); % É por isto que indices começam do zero!!!
			u(2,i) += ( invMatrix(i,j) * ( -1*(h.^2) * f(x,L) / ( E * A ) ) );
		end
		u(2,i) += ( invMatrix(i,n) * ( h * F * L / ( A * E ) ) );

		msg = sprintf('%d/%d', i, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	
		ponto += h;
	end
end

function u = calcComForca5();
	u = zeros(2,n);
	ponto = 0;
	for i = 1 : 1 : n
		u(1,i) = ponto;

		for j = 2 : 1 : n-1
			x = h*(j-1); % É por isto que indices começam do zero!!!
			u(2,i) += ( invMatrix(i,j) * ( -1*(h.^2) * f(x,L) / ( E * A ) ) );
		end
		u(2,i) += ( invMatrix(i,n) * ( h * F * L / ( A * E ) ) );

		msg = sprintf('%d/%d', i, n);
		printf([reverseStr, msg])
		reverseStr = repmat(sprintf('\b'), 1, length(msg));
	
		ponto += h;
	end
end

function deslAnalit = getFuncAnal();
	if strcmp(data.funcstr,('sen(πx/L)'))
		if data.state == 0
			deslAnalit = @(x,L,E,A,F) (  ((L/pi).^2) * (sin(pi*x/L)) / (E*A)  );
		%elseif data.state == 1
			%deslAnalit = @(x,L,E,A,F) (    )
		elseif data.state >= 2
			deslAnalit = @(x,L,E,A,F) (  (((L/pi).^2) * sin(pi*x/L) / (E*A)) + (F*x/(E*A))  );
		end
	elseif strcmp(data.funcstr,('exp(x)'))
		if data.state == 0
			deslAnalit = @(x,L,E,A,F) ( - ( exp(x) + (x/L)*(1-exp(L)) - 1 ) / (E*A) );
		elseif data.state >= 2
			deslAnalit = @(x,L,E,A,F) ( - ( exp(x) + (x/L)*(1-F*L-exp(L)) - 1 ) / (E*A) );
		end
	elseif strcmp(data.funcstr,'12x²+6')
		if data.state == 0
			deslAnalit = @(x,L,E,A,F) ( - ( (x.^4) + (3*x) - (x*(3+(L.^3))) ) / (E*A)  );
		elseif data.state >= 2
			deslAnalit = @(x,L,E,A,F) ( - (  (x.^4) + (3*x) - (F+(L.^3)+3)*x  ) / (E*A)  );
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
			deslAnalit = @(x,L,E,A,F) (- ( (iif(x) - (iif(L)*x/L)) / (E*A) ) );
		elseif data.state >= 2
			deslAnalit = @(x,L,E,A,F) (- (( iif(x) - F*x - (iif(L)*x/L) )/(E*A)) );
		end   % Fim da esparguete.
	end
end



% __________________________________________________________________________ %
L = data.comp;
f = data.cargaAxial;
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
reverseStr = '';


if data.option == 3
	top = 200;
	k = 1;
	for i = 5 : 5 : top
		clc
		printf('A calcular com 3 pontos...\n')
		printf('%d/%d\n',i,top)
		data.n = n  = i;
		h = L / (n - 1);
		data.pontos = 3;
		invMatrix   = createMatrix(data);
		printf('A calcular o deslocamento\n')
		u3{k} = calcEntreParedes3;
		
		k += 1;
	end
	k = 1;
	for i = 5 : 5 : top
		clc
		printf('A calcular com 5 pontos...\n')
		printf('%d/%d\n',i,top)
		data.n = n  = i;
		h = L / (n - 1);
		data.pontos = 5;
		invMatrix   = createMatrix(data);
		printf('A calcular o deslocamento...\n')
		u5{k} = calcEntreParedes5;

		k += 1;
	end
	printf('\nA calcular analiticamente...\n')
	deslAnalit = getFuncAnal();
	printf('\nA calcular o erro relativo para 3 pontos...\n')
	for i = 1 : 1 : length(u3)
		for k = 2 : 1 : length(u3{i})-1
			tempError(k-1) = ( u3{i}(2,k) - deslAnalit(u3{i}(1,k),L,E,A,F) )/deslAnalit(u3{i}(1,k),L,E,A,F);
		end
		errorX(i)  = L / ( (i * 5) - 1 );
		error3Y(i) = max(tempError);
	end
	printf('A calcular o erro relativo para 5 pontos...\n')
	for i = 1 : 1 : length(u5)
		for k = 2 : 1 : length(u5{i})-1
			tempError(k-1) = ( u5{i}(2,k) - deslAnalit(u5{i}(1,k),L,E,A,F) )/deslAnalit(u5{i}(1,k),L,E,A,F);
		end
		error5Y(i) = max(tempError);
	end
	figure
	loglog(errorX,error3Y,'*')
	title('Erro relativo')
	xlabel('espaçamento')
	ylabel('erro relativo')
	hold on
	loglog(errorX,error5Y,'d')
	legend('3 pontos','5 pontos')
	hold off

	printf('\nPressione qualquer tecla para continuar...')
	pause
	return;
end


n = double(data.n);
h = L / (n - 1);


invMatrix = createMatrix(data);


printf('A calcular o deslocamento por diferenças finitas...\n')
if data.state == 0 && data.pontos == 3
	u = calcEntreParedes3;
elseif data.state == 1 && data.pontos == 3
	u = calcComMola3;
elseif data.state >= 2 && data.pontos == 3
	u = calcComForca3;
elseif data.state == 0 && data.pontos == 5
	u = calcEntreParedes5;
elseif data.state == 1 && data.pontos == 5
	u = calcComMola5;
elseif data.state >= 2 && data.pontos == 5
	u = calcComForca5;
end


printf('\n')


if data.option == 2
	printf('A calcular analiticamente...\n')
	deslAnalit = getFuncAnal();
	printf('A calcular o erro relativo...\n')
	for k = 1 : 1 : n-1
		erroX(k) = u(1,k);
		erroY(k) = abs( ( u(2,k) - deslAnalit(u(1,k),L,E,A,F) ) / deslAnalit(u(1,k),L,E,A,F) );
	end
end


printf('A criar o gráfico...\n')
for k = 1 : 1 : n
	X(k)   = u(1,k);
	dfY(k) = u(2,k);  % Diferenças finitas
end
if data.option == 2
	for k = 1 : 1 : n
		aY(k) = deslAnalit(u(1,k),L,E,A,F);  % Analiticamente
	end
end
figure
if data.option == 1
	scatter(X,dfY,'*')
	axis([0 L -inf inf])
	title('Gráfico do deslocamento')
	xlabel('x (m)')
	ylabel('u(x) (nm)')
elseif data.option == 2
	subplot(2,1,1);
	scatter(X,dfY,'*')

	hold on
	scatter(X,aY)
	legend({'Diferenças finitas','Analiticamente'},'Location','northwest')
	title('Gráfico do deslocamento')
	xlabel('x (m)')
	ylabel('u(x) (nm)')
	axis([0 L -inf inf])

	subplot(2,1,2);
	scatter(erroX,erroY)
	title('Erro relativo')
	xlabel('x (m)')
	ylabel('erro relativo')
	axis([0 L -inf inf])

	hold off
end


printf('\nPressione qualquer tecla para continuar...')
pause


end % if you end a nested function you need to end the parent
