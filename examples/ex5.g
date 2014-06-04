% license: the BSD license
% version: 0.0.1
% name: A very simple calculator, inlined
% author: David Baumgartner

add : String → String → Integer % Adds a to b
add a b = 
	<(str_to_int a) + (str_to_int b)>.

sub : String → String → Integer % Substracts b to a
sub a b = 
	<(str_to_int a) - (str_to_int b)>.

mul : String → String → Integer % Multiplies a by b
mul a b = 
	<(str_to_int a) * (str_to_int b)>.

evalOp : String -> Integer % Evals a as an operator
evalOp s = 
	(λa ->
		if <(<a @ 1>) == "+"> →
			add <a @ 0>, <a @ 2>
		else
			if <(<a @ 1>) == "-"> →
				sub <a @ 0>, <a @ 2>
			else
				if <(<a @ 1>) == "*"> →
					mul <a @ 0>, <a @ 2>
				else
					error "Unsupported operation"
				end
			end
		end) (split " ", s).

main : None % Main
main = 
	print (
		evalOp input).
