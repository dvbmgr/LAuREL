#coding: utf8
import random
import string
import errors

def generateRandomName(size=20, chars=string.ascii_uppercase + string.digits):
	return ''.join(random.choice(chars) for x in range(size))

def getTypeByName(name):
	t = {
		'Integer': Integer,
		'Float': Float,
		'Atom': Atom,
		'String': String
	}
	if name in t:
		return t[name]
	else:
		if name[0] == '[' and name[-1] == ']':
			return List.partial_init(getTypeByName(name[1:-1]))
	raise SyntaxError("Unknown type %s" % name)

class Type:
	s_tk = None
	name = "Undefined"
	value = None
	
	def __init__(self, s_tk, value):
		self.s_tk = s_tk
		self.value = value

	def getValue(self):
		return self.value

	def getType(self):
		return self.name

	def getStk(self):
		return self.s_tk

class Integer(Type):
	name = "Integer"
	pass

class Float(Type):
	name = "Float"
	pass

class Atom(Type):
	name = "Atom"
	pass

class String(Type):
	name = "String"
	pass

class List(Type):
	name = None
	value = []

	def partial_init(self, vtype):
		self.vtype = vtype
		return (lambda u: List(vtype, u))

	def __init__(self, vtype, element):
		self.vtype = vtype
		self.add(element)

	def add(self, element):
		if isinstance(element, list):
			for el in element:
				self.add(el)
		elif isinstance(element, Type):
			if isinstance(element, self.vtype):
				self.value.append(element)
			else:
				raise TypeError("Oops. Trying to add %s to a %s list." % (element.getType(), self.name))
		else:
			raise TypeError("Trying to add something that isn't supposed to be added… (internal error)")
		return True

	def getType(self):
		return ("[" + name.getType() + "]")

class Call:
	s_tk = None
	function = None
	applied = []

	def __init__(self, s_tk, function, elements):
		self.s_tk = s_tk
		self.function = function
		self.add(elements)

	def add(self, element):
		if isinstance(element, list):
			for el in element:
				self.add(el)
		else:
			self.applied.append(element)

	def getStk(self):
		return self.s_tk

class Function:
	s_tk = None
	name = None
	types = []
	internal_names = []
	internals = None

	def __init__(self, s_tk, name, types, internal_names, internals):
		self.s_tk = s_tk
		self.name = name 
		self.types = types
		self.internal_names = internal_names
		self.internals = internals

	def getName(self):
		return self.name

	def getInternalNames(self):
		return self.internal_names

	def getInternals(self):
		return self.internals

	def getStk(self):
		return self.s_tk

class Lambda(Function):
	def __init__(self, s_tk, internal_names, internals):
		self.s_tk = s_tk
		self.name = generateRandomName()
		self.types = [Type for v in internal_names]
		self.internal_names = internal_names
		self.internals = internals

class If:
	s_tk = None
	cond = True
	ok = None
	nope = None

	def __init__(self, s_tk, cond, ok, nope):
		self.s_tk = s_tk
		self.cond = cond
		self.ok = ok 
		self.nope = nope

	def getStk(self):
		return self.s_tk