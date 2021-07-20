extends Spatial


func _ready():
	pass


func _process(delta):
#	$Player.rotate_y(1)
	var basis : Basis = $Player/VRMain.get_controller_orientation()
	var rot : Quat = basis.get_rotation_quat()
	$Player.rotate_y(rot.y * .1)
	pass
	

func _on_VRMain_controller_pressed():
	print("Main: Controller pressed")
	$Player.accelerate()
	pass


func _on_VRMain_controller_released():
	print("Main: Controller released")
	$Player.brake()
	pass


func _on_Player_entity_left_area(body):
	body.queue_free()
	pass
