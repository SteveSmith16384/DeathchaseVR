class_name Player
extends KinematicBody

signal entity_left_area

var accel = false
var speed: float = 0
var direction = Vector3()


func _ready():
	pass


func _process(delta):
	if accel:
		speed += 1
	else:
		speed -= 1
		if speed < 0:
			speed = 0

	if Globals.AUTO_TURN:
		speed = 3
		self.rotate_y(0.1 * delta)
		
	self.move_and_slide(direction * speed, Vector3.UP)
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


func get_random_position() -> Vector3:
	var idx = Globals.rnd.randi_range(1, $SpawnPoints.get_child_count())
	return $SpawnPoints.get_node("Position3D_" + str(idx)).get_global_transform().origin

