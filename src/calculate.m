%function calculate(data)
function matrix = calculate

reverseStr = '';
n = input('==> ');
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
disp('')
matrix(n,n) = 1;
