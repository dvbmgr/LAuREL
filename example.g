main : None → None
main a := 
	a.

add : String → String → Integer 
add a b := 
	(str_to_int a) + (str_to_int b).

sub : String → String → Integer 
sub a b := 
	(str_to_int a) - (str_to_int b).

mul : String → String → Integer 
mul a b := 
	(str_to_int a) * (str_to_int b).

evalOp : String → Integer 
evalOp s := 
	(λa →
		(if ((a @ 1) == "+") →
			(add (a @ 0) (a @ 2))
		else
			(if ((a @ 1) == "-") →
				(sub (a @ 0) (a @ 2))
			else
				(if ((a @ 1) == "*") →
					(mul (a @ 0) (a @ 2))
				else
					(error "Unsupported operation")
				end)
			end)
		end)).
