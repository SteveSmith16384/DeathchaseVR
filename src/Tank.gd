extends Spatial

const DIST : float = 30.0

var player : Player
var main : Main

var angle_to_player : float = PI*2

func _ready():
	main = get_tree().get_root().get_node("Main")
	player = main.get_node("Player")
	pass


func _process(delta):
	angle_to_player += delta * -0.1
	
	var x : float = sin(angle_to_player) * -DIST
	var z : float = cos(angle_to_player) * -DIST
	
	var offset = player.translation
	offset.x += x
	offset.z += z
	
	self.translation = offset
	pass


func hit_by_rocket():
	main.small_explosion(self)
	self.queue_free()
	pass
	