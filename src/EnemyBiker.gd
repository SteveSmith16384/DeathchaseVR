extends Spatial

const MIN_DIST = 20
const MAX_DIST = 40

var player : Player
var main : Main

var angle_to_player : float = PI
var dist : float = 20
var rotation_dir = 1
var fwd_back_dir = -1

func _ready():
	main = get_tree().get_root().get_node("Main")
	player = main.get_node("Player")
	pass


func _process(delta):
	dist += delta * fwd_back_dir * 2
	if fwd_back_dir < 0 and dist < MIN_DIST:
		fwd_back_dir = 1
	elif fwd_back_dir > 0 and dist > MAX_DIST:
		fwd_back_dir = -1
	
	if Globals.rnd.randi_range(0, 30) == 0:
		rotation_dir = Globals.rnd.randi_range(-1, 1)
		$Sprite3D_Left.visible = rotation_dir == 1
		$Sprite3D_Right.visible = rotation_dir == -1
		$Sprite3D_Forward.visible = rotation_dir == 0
		
	angle_to_player += delta * rotation_dir / dist
	
	var x : float = sin(angle_to_player) * -dist
	var z : float = cos(angle_to_player) * -dist
	
	var offset = player.translation
	offset.x += x
	offset.z += z
	
	self.translation = offset
	pass


func hit_by_rocket():
	main.small_explosion(self)
	self.queue_free()
	pass
	
