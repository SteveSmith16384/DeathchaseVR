#class_name Globals
extends Node


var rnd : RandomNumberGenerator

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

