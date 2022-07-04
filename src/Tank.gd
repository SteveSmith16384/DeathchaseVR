extends Spatial

const DIST : float = 60.0

var player #: Player
var main #: Main

var angle_to_player : float = PI*2

func _ready():
	main = get_tree().get_root().get_node("Main")
	player = main.get_node("Player")
	pass


func _process(delta):
	angle_to_player += delta * -0.08
	
	var x : float = sin(angle_to_player) * -DIST
	var z : float = cos(angle_to_player) * -DIST
	
	var offset = player.translation
	offset.x += x
	offset.z += z
	
	self.translation = offset
	self.translation.y = 0
	pass


func hit_by_rocket():
	main.inc_score(5000)
	main.small_explosion(self)
	self.queue_free()
	pass
	
