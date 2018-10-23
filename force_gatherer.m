function Force = force_gatherer(comp)

acceptZero = true;
clc
iterator = 1;
num_of_forces = 0;
printf('Forças aplicadas na barra:\n')
moreForces = true;
while moreForces
	b = input(' => Acrescentar força? [Y/n] ', 's');
	if b == 'Y' || b == 'y' || size(b) == 0
		printf('\nPosição (x) da força: \n')
		temp = input_tool(acceptZero);
		if temp <= comp
			Force(1, iterator) = temp;
		else 
			printf('\nIntroduza um valor menor que o comprimento da barra\n')
			continue
		end
		printf('\nMódulo da força:\n')
		temp = input_tool(acceptZero);
		Force(2, iterator) = temp;
		iterator += 1;
		num_of_forces += 1;
	elseif num_of_forces == 0;
		printf('\nTem de introduzir pelo menos uma força\n')
		continue
	else
		return;
	end
end
