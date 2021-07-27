class_name Player
extends KinematicBody

const MAX_SPEED = 15

onready var rocket_class = preload("res://Rocket.tscn")

signal entity_left_area

var player_start_y : float

var accel = false
var shooting = false
var speed: float = 0
var move_dir : Vector3 = Vector3(0, 0, 1)


func _ready():
	player_start_y = translation.y
	pass


func _process(delta):
	# Position player
	translation.y = self.player_start_y
	
	if accel:
		shooting = true
		speed += 1
		if speed > MAX_SPEED:
			speed = MAX_SPEED
	else:
		shooting = false
		speed -= 1
		if speed < 0:
			speed = 0

	if Globals.AUTO_TURN:
		speed = 3
		#self.rotate_y(0.1 * delta)
		
#	self.move_and_slide(direction * speed, Vector3.UP)
#	var slide_count = get_slide_count()
#	if slide_count > 0:
		# Crash!
#		speed = 0
	pass


func accelerate():
	accel = true
	pass
	
	
func brake():
	accel = false
	pass


func _on_RemovalArea_body_shape_exited(body_id, body, body_shape, local_shape):
	emit_signal("entity_left_area", body)
	pass


func get_random_global_spawn_position() -> Vector3:
	var idx = Globals.rnd.randi_range(1, $SpawnPoints.get_child_count())
	return $SpawnPoints.get_node("Position3D_" + str(idx)).get_global_transform().origin



func _on_ShootTimer_timeout():
	if shooting || Globals.AUTO_SHOOT:
		var rocket = rocket_class.instance();
		rocket.move_dir = move_dir
		rocket.translation = $Muzzle.translation
		self.add_child(rocket)
		pass
	pass
