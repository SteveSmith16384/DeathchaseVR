#class_name Globals
extends Node

const VERSION = "0.1"
const RELEASE_MODE = false

const AUTO_TURN = false and !RELEASE_MODE
const AUTO_SHOOT = false and !RELEASE_MODE


var rnd : RandomNumberGenerator

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

