class_name Player
extends Spatial

const MAX_SPEED = 30

onready var rocket_class = preload("res://Rocket.tscn")

signal entity_left_area

var main
var player_start_y : float
var accel = false
var shooting = false
var speed: float = 0
var move_dir : Vector3 = Vector3(0, 0, 1)


func _ready():
	main = get_tree().get_root().get_node("Main")
	player_start_y = 0#translation.y
	pass


func _process(delta):
	translation.y = self.player_start_y
	
	if accel:
		shooting = true
		speed += 5 * delta
		if speed > MAX_SPEED:
			speed = MAX_SPEED
	else:
		shooting = false
		speed -= 10 * delta
		if speed < 0:
			speed = 0

	if Globals.AUTO_TURN:
		speed = 3
		#self.rotate_y(0.1 * delta)
		
	pass


func accelerate():
	accel = true
	pass
	
	
func brake():
	accel = false
	pass


func _on_RemovalArea_body_shape_exited(body_id, body, body_shape, local_shape):
	pass


func _on_RemovalArea_area_exited(area : Area):
	var owner = area.get_parent_spatial()
	emit_signal("entity_left_area", owner)
	pass


func get_random_global_spawn_position() -> Vector3:
	var idx = Globals.rnd.randi_range(1, $SpawnPoints.get_child_count())
	return $SpawnPoints.get_node("Position3D_" + str(idx)).get_global_transform().origin


func _on_ShootTimer_timeout():
	if shooting || Globals.AUTO_SHOOT:
		var rocket = rocket_class.instance();
		rocket.translation = $Muzzle.get_global_transform().origin
		rocket.translation.y = 0
		rocket.move_dir = move_dir
		main.add_child(rocket)
	pass


func hit_tree():
	$Audio_Crash.play()
	speed = 0
	pass

