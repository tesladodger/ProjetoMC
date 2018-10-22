function [area, comp, mola1, mola2, k1, k2, forc, n] = gatherer

area = 0;
comp = 0;
mola1 = false;
mola2 = false;
k1 = 0;
k2 = 0;
forc = 0;
n = 0;
valid = true;
while valid
	try
		area = input('Area da seccao reta => ');
	catch error
		errr;
		valid = false;
		break;
	end
	try
		comp = input('Comprimento => ');
	catch error
		errr;
		valid = false;
		break;
	end
	mola1 = input('O primeiro apoio e uma mola? (Y,n): ', 's');
	if mola1 == 'y' || mola1 == 'Y'
		mola1 = true;
		try
			k1 = input('Constante => ')
		catch error
			errr;
			valid = false;
			break;
		end
	end
	mola2 = input('O segundo apoio e uma mola? (Y,n): ', 's');
	if mola2 == 'y' || mola2 == 'Y'
		mola2 = true;
		try
			k2 = input('Constante => ');
		catch error
			errr;
			valid = false;
			break;
		end
	end
	valid = false;
	break;

end
