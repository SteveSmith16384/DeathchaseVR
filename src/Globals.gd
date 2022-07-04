extends Node

const VERSION = "0.1"
const RELEASE_MODE = false

const TEST_GAME = true and !RELEASE_MODE
const AUTO_SHOOT = false and !RELEASE_MODE

var NUM_TREES = 10#14
var num_bikers = 0
var level = 1
var score : float = 0
var lives: int

var rnd : RandomNumberGenerator

func _ready():
	rnd = RandomNumberGenerator.new()
	rnd.randomize()
	pass
	

