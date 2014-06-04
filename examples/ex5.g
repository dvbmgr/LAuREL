% license: the BSD license
% version: 0.0.1
% name: A very simple calculator, inlined
% author: David Baumgartner

add : String → String → Integer
add a b := 
	(str_to_int (a)) + (str_to_int (b)).

sub : String → String → Integer
sub a b := 
	(str_to_int (a)) - (str_to_int (b)).

mul : String → String → Integer
mul a b := 
	(str_to_int (a)) * (str_to_int (b)).

evalOp : String → Integer
evalOp s := 
	let
		interpred := (λ a →
						if (a @ 1) == "+" →
							add (a @ 0) (a @ 2)
						else
							if (a @ 1) == "-" →
								sub (a @ 0) $ a @ 2
							else
								if ((a) @ 1) == "*" →
									mul ((a) @ 0) ((a) @ 2)
								else
									error "Unsupported operation") 
	in
		interpred $ split " " s.

main : None
main := 
	print $ evalOp input.
