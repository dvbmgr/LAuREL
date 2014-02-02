from __future__ import print_function

import sys
import os
from LAuREL import errors
from LAuREL.parser import r_input as p_input
from LAuREL.lexer import r_input as l_input, find_column
from LAuREL.colors import bcolors

def call(args, filename):
	with open(filename) as f:
		d = f.read()
		a_lineno = -1
		if len(args) < 2 or len(args) > 3:
			print("Usage: python example.py [-p|-l]", file=sys.stderr)
		elif args[1] == "-l":
			ld = l_input(filename, d)
			if len(args) == 3:
				u = (args[2]).split("-")
				d_lim, u_lim = int(u[0]), int(u[1 if len(u) == 2 else 0])+1
				f = True
			else:
				d_lim, u_lim = 0, 0
				f = False
			for r in ld:
				if (not (int(r.lineno) in range(d_lim, u_lim))) and f:
					continue
				if a_lineno != r.lineno:
					print(bcolors.INFORMATION, "[",filename,":",r.lineno, "]", bcolors.ENDC, d.split("\n")[r.lineno-1].strip())
					a_lineno = r.lineno
				print("\t", bcolors.BOLD, r.value, bcolors.ENDC, "is lexed as", bcolors.TOKEN, r.type, bcolors.ENDC)
		elif args[1] == "-p":
			try:
				print(p_input(filename, d))
			except errors.LAuRELError, e:
				print(e)

if __name__ == "__main__":
	call(sys.argv, "example.g")