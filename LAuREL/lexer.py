#coding: utf8

from ply import lex
import pprint

import ast 
import errors

input_data = ""

tokens = (
   'LET',
   'IN',
   'IF',
   'ELSE',
   'END',
   'CASE',
   'OF',
   'OPERATOR',
   'RIGHT_OP',
   'LPAREN',
   'RPAREN',
   'LBRACE',
   'RBRACE',
   'LSBRACE',
   'RSBRACE',
   'COMMA',
   'NAME',
   'TYPE',
   'FLOAT',
   'INTEGER',
   'DOT',
   'SEMICOLON',
   'TO',
   'FROM',
   'LAMBDA',
   'TYPE_SEPARATOR',
   'STRING',
   'ATOM',
   'COMMENT',
   'ASSIGN',
)

reserved = {
   'let' : 'LET',
   'in' : 'IN',
   'if' : 'IF',
   'else' : 'ELSE',
   'end' : 'END',
   'case' : 'CASE',
   'of' : 'OF',
}

t_LET = r'let'
t_IN = r'in'
t_IF = r'if'
t_ELSE = r'else'
t_END = r'end'
t_CASE = r'case'
t_OF = r'of'
t_LPAREN = r'\('
t_RPAREN = r'\)'
t_LBRACE = r'\['
t_RBRACE = r'\]'
t_LSBRACE = r'\{'
t_RSBRACE = r'\}'
t_OPERATOR = r'(?!(:?->|<-))[\+\-*<>\/\?@=]+'
t_RIGHT_OP = r'(:?\$+)'
t_NAME = r'(?!let|in|if|else|end|case|of)[a-z_][a-zA-Z0-9_]*\'?'
t_TYPE = r'[A-Z][a-zA-Z]+'
t_ASSIGN = r':='
t_COMMA = r','
t_TO = r'(:?(:?\->)|→)'
t_FROM = r'(:?(:?<\-)|←)'


def t_FLOAT(t):
	r'\d*\.\d+'
	t.value = float(t.value)
	return t

def t_INTEGER(t):
	r'\d+'
	t.value = int(t.value)
	return t

t_DOT = r'\.'
t_SEMICOLON = r';'
t_LAMBDA = r'(:?\\|λ)'
t_TYPE_SEPARATOR = r':'

def t_STRING(t):
	r'("(\\"|[^"])*")'
	t.value = t.value[1:-1]
	return t

def t_ATOM(t):
	r':[a-z]+'
	t.value = t.value[1:]
	return t

	
def t_COMMENT(t):
	r'(%[^%]*%)'
	t.value = t.value[1:-1]
	return t

def t_newline(t):
	r'\n+'
	t.lexer.lineno += t.value.count("\n")
	
def t_error(t):
	global input_data
	t.lexer.skip(1)
	raise errors.LAuRELUnvalidToken("illegal character", t, input_data)

t_ignore = " \t"

import logging
logging.basicConfig(
	level = logging.DEBUG,
	filename = "parselog.txt",
	filemode = "w",
	format = "%(filename)10s:%(lineno)4d:%(message)s"
)
log = logging.getLogger()

lexer = lex.lex(debuglog=log)

def find_column(input,token):
	last_cr = input.rfind('\n',0,token.lexpos)
	if last_cr < 0:
		last_cr = 0
	column = (token.lexpos - last_cr)
	return column

def r_input(fn, f):
	global input_data
	input_data = fn, f
	u = lexer.input(f)
	o = []
	while True:
		tok = lexer.token()
		if not tok: break
		o.append(tok)
	return o