% This is the most advanced example done so far…

% license: The BSD license
% version: 0.0.1
% name: A very simple calculator
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
evalOp a = 
	if <a == "+"> →
		add (input), (input)
	else
		if <a == "-"> →
			sub (input), (input)
		else
			if (<a == "*">) →
				mul (input), (input)
			else
				error "Unsupported operation"
			end
		end
	end.

main : None % Mains
main = 
	<print "Hello" ;
		(print (
		evalOp input))>.
