extends KinematicBody

signal entity_left_area

var accel = false
var speed: float = 0
var dir = Vector3.FORWARD


func _ready():
	pass


func _process(delta):
	if accel:
		speed += 1
	else:
		speed -= 1
		if speed < 0:
			speed = 0

	self.move_and_slide(dir * speed, Vector3.UP)
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
