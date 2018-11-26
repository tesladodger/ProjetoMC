function calculate(data)

% Esta função efectua os cálculos do deslocamento, por diferenças finitas e, se
% a função não for genérica, calcula o valor real e o erro. Posteriormente, são
% desenhados os gráficos do deslocamento e erro.
% Há três funções para o cálculo das dif. fin. porque é consideravelmente mais
% rápido do que condicionar internamente apenas uma função.


function u = calcEntreParedes();
    u = zeros(2,n);
    ponto = 0;
    for i = 1 : 1 : n
        u(1,i) = ponto;

        for j = 2 : 1 : n-1
            x = h*(j-1); % É por isto que indices começam do zero!!!
            u(2,i) += ( invMatrix(i,j) * ( -(h.^2) * f(x) / ( E * A ) ) );
        end

        msg = sprintf('%d/%d', i, n);
        printf([reverseStr, msg])
        reverseStr = repmat(sprintf('\b'), 1, length(msg));

        ponto += h;
    end
end

function u = calcComMola();
    u = zeros(2,n);
    ponto = 0;
    for i = 1 : 1 : n
        u(1,i) = ponto;

        for j = 2 : 1 : n-1
            x = h*(j-1);
            u(2,i) += ( invMatrix(i,j) * ( -(h.^2) * f(x) / (E*A) ) );
        end

        msg = sprintf('%d/%d', i, n);
        printf([reverseStr, msg])
        reverseStr = repmat(sprintf('\b'), 1, length(msg));

        ponto += h;
    end
end

function u = calcComForca();
    u = zeros(2,n);
    ponto = 0;
    for i = 1 : 1 : n
        u(1,i) = ponto;

        for j = 2 : 1 : n-1
            x = h*(j-1);
            u(2,i) += ( invMatrix(i,j) * ( -(h.^2) * f(x) / (E*A) ) );
        end

        u(2,i) += ( invMatrix(i,n) * (  h * F / ( E * A ) ) );

        msg = sprintf('%d/%d', i, n);
        printf([reverseStr, msg])
        reverseStr = repmat(sprintf('\b'), 1, length(msg));
    
        ponto += h;
    end
end

function deslAnalit = getFuncAnalit();
    L=L;E=E;A=A;F=F;k=k; % Não sei porque é que tenho de fazer isto

    if strcmp(data.funcstr,('sen(πx/L)'))
        if data.state == 0
            deslAnalit = @(x) (((L/pi).^2)*(sin(pi*x/L))/(E*A));
        elseif data.state == 1
            deslAnalit = @(x,L,E,A,F,k) (  (  ((L*pi).^2)*sin(pi*x/L) + x*((L/pi)-(k*(L.^2)/(pi*E*A)))  ) / (E*A)  );
        elseif data.state >= 2
            deslAnalit = @(x) ((((L/pi).^2)*sin(pi*x/L)+(F*x)+(L*x/pi))/(E*A));
        end

    elseif strcmp(data.funcstr,('exp(x)'))
        if data.state == 0
            deslAnalit = @(x) (-(exp(x)+(x/L)*(1-exp(L))-1)/(E*A));
        elseif data.state == 1
            C1 = ( exp(L) + k*exp(L)/(E*A) - k/(E*A) ) / ( 1 + k*L/(E*A) );
            deslAnalit = @(x) (  ( -exp(x) + C1*x + 1 ) / (E*A)  );
        elseif data.state >= 2
            deslAnalit = @(x) ((-exp(x)+F*x+exp(L)*x+1)/(E*A));
        end

    elseif strcmp(data.funcstr,'12x²+6')
        if data.state == 0
            deslAnalit = @(x) (-((x.^4)+(3*x.^2)-(x*((3*L)+(L.^3))))/(E*A));
        elseif data.state >= 2
            deslAnalit = @(x) (-((x.^4)+(3*x.^2)-(F*x)-(4*x*(L.^3))-(6*x*L))/(E*A));
        end

    else  % Quando é um polinómio (cuidado, esparguete):
        coef = data.coef;
        for i = 7 : -1 : 1  % Coeficientes do primeiro integral
            if !(coef(i) == 0) 
                c(i) = coef(i)/(i);
            else
                c(i) = 0;
            end
        end
        i1f = @(x) ((c(7)*x.^7)+(c(6)*x.^6)+(c(5)*x.^5)+(c(4)*x.^4)+(c(3)*x.^3)+(c(2)*x.^2)+(c(1)*x));
        for i = 7 : -1 : 1  % Coeficientes do segundo integral
            if !(coef(i) == 0)
                cc(i) = coef(i)/(i*(i+1));
            else
                cc(i) = 0;
            end
        end
        i2f = @(x) ((cc(7)*x.^8)+(cc(6)*x.^7)+(cc(5)*x.^6)+(cc(4)*x.^5)+(cc(3)*x.^4)+(cc(2)*x.^3)+(cc(1)*x.^2));
        if data.state == 0
            deslAnalit = @(x) (-((i2f(x)-(i2f(L)*x/L))/(E*A)));
        elseif data.state >= 2
            deslAnalit = @(x) (-((i2f(x)-F*x-(i1f(L)*x))/(E*A)));
        end   % Fim da esparguete.
    end
end



% _________________________main_function____________________________________ %
L = data.comp;
f = data.cargaAxial;
E = data.ymodul;
A = data.area;
if data.state >= 2
    F = data.force;
    k = 0;
elseif data.state == 1
    k = data.k;
    F = 0;
else
    F = 0;
    k = 0;
end
reverseStr = '';


% _______________________ Calcular o erro para diferentes valores de n _______
if data.option == 3
    if     (data.state == 0) calcFunc = @() calcEntreParedes();
    elseif (data.state == 1) calcFunc = @() calcComMola();
    elseif (data.state >= 2) calcFunc = @() calcComForca();
    end
    top = 150;
    for i = 5 : 5 : top
        clc
        printf('A calcular com 3 pontos (%d/%d) \n',i,top)
        data.n = n  = i;
        h = L / (n - 1);
        data.pontos = 3;
        invMatrix   = createMatrix(data);
        printf('A calcular o deslocamento\n')
        u3{i/5} = calcFunc();
    end
    for i = 5 : 5 : top
        clc
        printf('A calcular com 5 pontos (%d/%d) \n',i,top)
        data.n = n  = i;
        h = L / (n - 1);
        data.pontos = 5;
        invMatrix   = createMatrix(data);
        printf('A calcular o deslocamento...\n')
        u5{i/5} = calcFunc();
    end
    printf('\nA calcular analiticamente...\n')
    deslAnalit = getFuncAnalit();
    printf('\nA calcular o erro relativo médio para 3 pontos...\n')
    for i = 1 : 1 : length(u3)
        for j = 2 : 1 : length(u3{i})-1
            tempError(j-1) = ( u3{i}(2,j) - deslAnalit(u3{i}(1,j)) ) / deslAnalit(u3{i}(1,j));
        end
        errorX(i)  = abs(log10(L / ( (i * 5) - 1 )));
        error3Y(i) = abs(log10(sum(abs(tempError))/(i*5)));
    end
    printf('A calcular o erro relativo médio para 5 pontos...\n')
    for i = 1 : 1 : length(u5)
        for j = 2 : 1 : length(u5{i})-1
            tempError(j-1) = ( u5{i}(2,j) - deslAnalit(u5{i}(1,j)) ) / deslAnalit(u5{i}(1,j));
        end
        error5Y(i) = abs(log10(sum(abs(tempError))/(i*5)));
    end
    figure
    subplot(2,1,1)
    loglog(errorX,error3Y,'*')
    title('Erro Relativo Para 3 Pontos')
    xlabel('espaçamento')
    ylabel('erro relativo')

    subplot(2,1,2)
    loglog(errorX,error5Y,'*')
    title('Erro Relativo Para 5 Pontos')
    xlabel('espaçamento')
    ylabel('erro relativo')

    printf('\nPressione qualquer tecla para continuar...')
    pause
    return;
end


n = double(data.n);
h = L / (n - 1);


invMatrix = createMatrix(data);


printf('A calcular o deslocamento por diferenças finitas...\n')
if data.state == 0
    u = calcEntreParedes();
elseif data.state == 1
    u = calcComMola();
elseif data.state >= 2
    u = calcComForca();
end


printf('\n')


if data.option == 2
    printf('A calcular analiticamente...\n')
    deslAnalit = getFuncAnalit();
    printf('A calcular o erro relativo...\n')
    for i = 2 : 1 : n-1
        erroX(i-1) = u(1,i);
        erroY(i-1) = abs( ( u(2,i) - deslAnalit(u(1,i)) ) / deslAnalit(u(1,i)) );
    end
end


printf('A criar o gráfico...\n')
for i = 1 : 1 : n
    X(i)   = u(1,i);
    dfY(i) = u(2,i) * (10.^9);                 % Diferenças finitas
end
if data.option == 2
    for i = 1 : 1 : n
        aY(i) = deslAnalit(u(1,i)) * (10.^9);  % Analiticamente
    end
end
figure
if data.option == 1
    scatter(X,dfY,'*')
    xlim([0 L])
    title('Gráfico do deslocamento')
    xlabel('x [m]')
    ylabel('u(x) [nm]')
elseif data.option == 2
    subplot(2,1,1);
    scatter(X,dfY,'*')

    hold on
    scatter(X,aY)
    xlim([0 L])
    legend({'Diferenças finitas','Analiticamente'},'Location','northwest')
    title('Gráfico do deslocamento')
    xlabel('x [m]')
    ylabel('u(x) [nm]')

    subplot(2,1,2);
    scatter(erroX,erroY)
    xlim([0 L])
    title('Erro relativo')
    xlabel('x [m]')
    ylabel('erro relativo')

    hold off
end


printf('\nPressione qualquer tecla para continuar...')
pause


end % if you have a nested function you need to end the parent
