#coding: utf8

import ply.yacc as yacc
import ast
import errors
import lexer


precedence = (
    ('left', 'OPERATOR'),
    ('right', 'RIGHT_OP'),
)

def p_functions_list(p):
	'''
	functions : functions function
	'''
	p[0] = p[1] + [p[2]]

def p_functions(p):
	'''
	functions : function
	'''
	p[0] = [p[1]]

def p_function(p):
	'''
	function : NAME TYPE_SEPARATOR types NAME arguments ASSIGN expr DOT
	'''
	assert(p[1] == p[4])
	p[0] = ast.Function(p, p[1], p[3], p[5], p[7])

def p_types_list(p):
	'''
	types : types TO type 
	'''
	p[0] = p[1] + [p[2]]

def p_types(p):
	'''
	types : type
	'''
	p[0] = [p[1]]

def p_type(p):
	'''
	type : TYPE
	'''
	p[0] = ast.getTypeByName(p[1])

def p_arguments_list(p):
	'''
	arguments : arguments argument 
	'''
	p[0] = p[1] + [p[2]]

def p_arguments(p):
	'''
	arguments : argument
	'''
	p[0] = [p[1]]

def p_argument(p):
	'''
	argument : NAME
	'''
	p[0] = p[1]

def p_call_exprs(p):
	'''
	call : NAME exprs
	call : lambda exprs
	'''
	p[0] = ast.Call(p, p[1], p[2])

def p_call(p):
	'''
	call : NAME
	call : lambda
	'''
	p[0] = ast.Call(p, p[1], [])


def p_exprs_list(p):
	'''
	exprs : exprs expr 
	'''
	p[0] = p[1] + [p[2]]

def p_exprs(p):
	'''
	exprs : expr
	'''
	p[0] = [p[1]]

def p_expr_parenthesis(p):
	'''
	expr : LPAREN expr RPAREN
	'''
	p[0] = p[2]

def p_expr_operator(p):
	'''
	expr : expr OPERATOR expr 
	expr : expr RIGHT_OP expr
	'''
	p[0] = ast.Call(p, p[2], [p[1], p[3]])

def p_expr_call(p):
	'''
	expr : call
	'''
	p[0] = p[1]

def p_expr_lambda(p):
	'''
	expr : lambda
	'''
	p[0] = p[1]

def p_expr_if(p):
	'''
	expr : if 
	'''
	p[0] = p[1]

def p_expr_terms(p):
	'''
	expr : term
	'''
	p[0] = p[1]

def p_lambda(p):
	'''
	lambda : LAMBDA arguments TO expr 
	''' 
	p[0] = ast.Lambda(p, p[2], p[4])

def p_if(p):
	'''
	if : IF expr TO expr ELSE expr END
	'''
	p[0] = ast.If(p, p[2], p[4], p[6]) 

def p_terms_head(p):
	'''
	terms : LBRACE subterms COMMA term RBRACE
	'''
	p[0] = p[2].add(p[4])

def p_terms_single(p):
	'''
	terms : LBRACE subterms RBRACE 
	'''
	p[0] = p[2]

def p_terms_empty(p):
	'''
	terms : LBRACE RBRACE
	'''
	p[0] = ast.List(p, [])

def p_subterms_list(p):
	'''
	subterms : subterms term 
	'''
	p[0] = p[1].add(p[2])

def p_subterms(p):
	'''
	subterms : term
	'''
	p[0] = ast.List(p, p[1])

def p_term_float(p):
	'''
	term : FLOAT
	'''
	p[0] = ast.Float(p, p[1])

def p_term_integer(p):
	'''
	term : INTEGER
	'''
	p[0] = ast.Integer(p, p[1])

def p_term_string(p):
	'''
	term : STRING
	'''
	p[0] = ast.String(p, p[1])

def p_term_atom(p):
	'''
	term : ATOM
	'''
	p[0] = ast.Atom(p, p[1])

def p_term_terms(p):
	'''
	term : terms 
	'''
	p[0] = p[1]

def p_error(p):
	global input_data
	raise errors.LAuRELSyntaxError("unvalid input", p, input_data)

import logging
logging.basicConfig(
    level = logging.DEBUG,
    filename = "parselog.txt",
    filemode = "w",
    format = "%(filename)10s:%(lineno)4d:%(message)s"
)
log = logging.getLogger()


def r_input(fn, f):
	global input_data
	input_data = fn, f
	lexer.input_data = input_data
	tokens = lexer.tokens
	parser = yacc.yacc(debuglog=log)
	return parser.parse(f)
