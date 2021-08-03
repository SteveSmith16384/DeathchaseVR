extends Spatial

export var blue : bool = true

const TURN_SPEED = 8
const MIN_DIST = 30
const MAX_DIST = 50

var player# : Player
var main

var angle_to_player : float = 0#PI/2
var dist : float = 60
var rotation_dir = 1
var fwd_back_dir = -1

func _ready():
	main = get_tree().get_root().get_node("Main")
	player = main.get_node("Player")
	
	init()
	
	Globals.num_bikers += 1
	pass


func init():
	$YellowSprites.visible = not blue
	$BlueSprites.visible = blue
	pass
	

func _process(delta):
	if player.speed == 0:
		$YellowSprites/Sprite3D_Yellow_Left.visible = false
		$YellowSprites/Sprite3D_Yellow_Right.visible = false
		$YellowSprites/Sprite3D_Yellow_Forward.visible = true
		$BlueSprites/Sprite3D_Blue_Left.visible = false
		$BlueSprites/Sprite3D_Blue_Right.visible = false
		$BlueSprites/Sprite3D_Blue_Forward.visible = true
		return
	
	if player.speed < player.MAX_SPEED/3:
		fwd_back_dir = 1
		
	dist += delta * fwd_back_dir * 2
	if fwd_back_dir < 0 and dist < MIN_DIST:
		fwd_back_dir = 1
	elif fwd_back_dir > 0 and dist > MAX_DIST:
		fwd_back_dir = -1
	
	if Globals.rnd.randi_range(0, 30) == 0:
		rotation_dir = Globals.rnd.randi_range(-1, 1)
		$YellowSprites/Sprite3D_Yellow_Left.visible = rotation_dir == 1
		$YellowSprites/Sprite3D_Yellow_Right.visible = rotation_dir == -1
		$YellowSprites/Sprite3D_Yellow_Forward.visible = rotation_dir == 0
		$BlueSprites/Sprite3D_Blue_Left.visible = rotation_dir == 1
		$BlueSprites/Sprite3D_Blue_Right.visible = rotation_dir == -1
		$BlueSprites/Sprite3D_Blue_Forward.visible = rotation_dir == 0
		
	angle_to_player += delta * TURN_SPEED * rotation_dir / dist
	
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
	main.biker_killed()
	pass
	
