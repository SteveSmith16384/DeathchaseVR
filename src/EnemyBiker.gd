extends Spatial

var angle_to_player : float
var dist : float = 3
var player : Player
var dir = 1

func _ready():
	var main = get_tree().get_root().get_node("Main")
	player = main.get_node("Player")
	pass


func _process(delta):
	if Globals.rnd.randi_range(0, 20) == 0:
		dir = Globals.rnd.randi_range(-1, 1)
		$Sprite3D_Left.visible = dir == 1
		$Sprite3D_Right.visible = dir == -1
		$Sprite3D_Forward.visible = dir == 0
		
	angle_to_player += delta * dir * 0.8
	
	var x : float = sin(angle_to_player) * -dist
	var z : float = cos(angle_to_player) * -dist
	
	var offset = player.translation
	offset.x += x
	offset.z += z
	
	self.translation = offset
	pass
