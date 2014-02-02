import ast

t = []
t.append(ast.Function('str_to_int', [ast.String], "a", lambda a: ast.Integer(int(a))))

stdlib = {}

for fun in t:
	stdlib[fun.getName()] = fun