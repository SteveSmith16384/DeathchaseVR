extends Spatial

const MAX_HEIGHT = 5

const DIST : float = 30.0

var player : Player
var main : Main
var height : float = 0
var up_down_dir = 1

var angle_to_player : float = PI#*2

func _ready():
	main = get_tree().get_root().get_node("Main")
	player = main.get_node("Player")
	pass


func _process(delta):
	if up_down_dir < 0 and height <= 0:
		up_down_dir = 1
	elif up_down_dir > 0 and height > MAX_HEIGHT:
		up_down_dir = -1
	height += up_down_dir * delta * 10

	angle_to_player += delta * -.3
	
	var x : float = sin(angle_to_player) * -DIST
	var z : float = cos(angle_to_player) * -DIST
	
	var offset = player.translation
	offset.x += x
	offset.z += z
	
	self.translation = offset
	translation.y = height
	pass


func hit_by_rocket():
	main.small_explosion(self)
	self.queue_free()
	pass
	
