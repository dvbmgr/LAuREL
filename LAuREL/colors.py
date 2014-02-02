#coding: utf8

class bcolors:
	HEADER = '\033[95m'
	INFORMATION = '\033[94m'
	OK = '\033[92m'
	WARNING = '\033[93m'
	ERROR = '\033[91m'
	ENDC = '\033[0m'
	BOLD = '\033[1m'
	TOKEN = '\033[42m\033[99m'

	def __init__(self):
		if os.name != "posix":
			self.disable()

	def disable(self):
		self.HEADER = ''
		self.INFORMATION = ''
		self.OK = ''
		self.WARNING = ''
		self.ERROR = ''
		self.ENDC = ''