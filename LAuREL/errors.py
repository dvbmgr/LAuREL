from colors import bcolors
from lexer import find_column

import pprint

class LAuRELError(Exception):
	token = None
	message = ""
	errclass = "Error"
	input_data = None
	filename = None

	def __init__(self, message, token, input_data):
		self.token = token 
		self.filename, self.input_data = input_data
		line = token.lineno
		column = find_column(self.input_data, token)
		lines_bf = "\n".join([bcolors.OK + "\t| " + bcolors.ENDC + z for z in self.input_data.split("\n")[(line-3):(line-1)]])
		lines_ot = bcolors.ERROR + "\n\t| " + bcolors.ENDC + bcolors.BOLD + self.input_data.split("\n")[line-1] + bcolors.ENDC
		lines_af = "\n".join([bcolors.OK + "\t| " + bcolors.ENDC + z for z in self.input_data.split("\n")[(line):(line+2)]])
		lines = lines_bf + lines_ot + bcolors.ERROR + "\n\t| " + (" "*(column-1)) + ("^"*(len(str(token.value)))) + bcolors.ENDC + "\n" + lines_af
		self.message = (bcolors.ERROR + self.errclass + ": " + bcolors.ENDC + message + " near " + bcolors.BOLD + str(token.value) + bcolors.ENDC + " (which is lexed as " + bcolors.TOKEN + " " + token.type + " " + bcolors.ENDC + ")" + "\n" +
				bcolors.INFORMATION + "[ " + self.filename + " : " + str(line) + ":" + str(column) + " ]  " + "\n" + lines)

	def __str__(self):
		return self.message

class LAuRELSyntaxError(LAuRELError):
	errclass = "Syntax error"

class LAuRELUnvalidToken(LAuRELError):
	errclass = "Unvalid token"

class LAuRELTypeError(LAuRELError):
	errclass = "Unvalid type"

class LAuRELAlreadlyDefined(LAuRELError):
	errclass = "Already defined"