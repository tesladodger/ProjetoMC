function pol = getPolinomio()


for i = 6 : -1 : 0
	kmp = num2str(i);
	message = strcat('Coefiente do monómio de ordem: ', kmp, '\n');
	coef(i + 1) = getInput(message, 401, 1); % É por causa disto que
end                                          % indices começam do zero!!!
% É por causa disto que indices começam do zero!!!
pol = @(x,L) ( coef(7)*x^6 + coef(6)*x^5 + coef(5)*x^4 + coef(4)*x^3 + coef(3)*x^2 + coef(2)*x + coef(1) );
% É por causa disto que ind começam do zero!!!