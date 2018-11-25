function [pol, funcstr, coef] = getPolinomio()

% Função para criar um polinómio de grau máximo 6


function getFunky()
    suffix{1} = '';
    suffix{2} = 'x';
    suffix{3} = 'x²';
    suffix{4} = 'x³';
    suffix{5} = 'x⁴';
    suffix{6} = 'x⁵';
    suffix{7} = 'x⁶';
    funcstr   = '';
    coef(8)   = 0;
    counter   = 0;

    for i = 7 : -1 : 1

        message = sprintf('%s \nCoefiente do monómio de ordem %d:\n', funcstr, i-1);
        coef(i) = getInput(message, 401, 1);

        if !(coef(i) == 0)
            counter += 1;
            if (coef(i) > 0) && (counter > 1)
                coefstr = strcat( '+', num2str(coef(i)) , suffix{i} );
            else
                coefstr = strcat( num2str(coef(i)) , suffix{i} );
            end
            funcstr = strcat( funcstr , coefstr);
        end

    end

    if counter == 0
        funcstr = '0';
    end

    % É por causa disto que indices começam do zero!!!
    pol = @(x) ( coef(7)*x^6 + coef(6)*x^5 + coef(5)*x^4 + coef(4)*x^3 + coef(3)*x^2 + coef(2)*x + coef(1) );
    % É por causa disto que indices começam do zero!!!
end


% ___________________________________________
while true
    getFunky();

    clc
    printf('Polinómio: %s\n',funcstr)
    a = input('Pretende continuar? [Y/n] ', 's');

    if a == 'y' || a == 'Y' || size(a) == 0
        return;
    end
end


end  % If nested functions are present, all functions must be ended
