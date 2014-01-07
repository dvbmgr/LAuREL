x : Integer
x = 5

display : String -> Integer -> ()
display s i =
	if i > 5 ->
		print s, i.toString
	else
		()
	end

main : ()
main =
	display "…", x