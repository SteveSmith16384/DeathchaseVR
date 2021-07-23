extends Spatial

var player_start_y : float

func _ready():
	player_start_y = $Player.translation.y
	pass


func _process(delta):
	# Position player
	$Player.translation.y = self.player_start_y
	
	var controller_basis : Basis = $Player/VRMain.get_controller_orientation()
	$Player.direction = Vector3()
	$Player.direction -= controller_basis.z
	
	var global_pos = $Player.global_transform.origin
	var pos = global_pos + ($Player.direction * 10)
	pos.y = $Player.translation.y
	$Player.look_at(pos, Vector3.UP)
	
	return
	
	var controller_rot : Quat = controller_basis.get_rotation_quat().normalized()

	var head_basis : Basis = $Player/VRMain.get_head_orientation()
	var head_rot : Quat = head_basis.get_rotation_quat().normalized()

	var overall_rot = controller_rot.y - head_rot.y
	print("Controller Rot.y=" + str(controller_rot.y))
	print("Head Rot.y=" + str(head_rot.y))
	print("Total Rot.y=" + str(overall_rot))
	if abs(overall_rot) > 0.2:
#		if overall_rot > 0:
#			$Player.rotate_y(0.1)
#		else:
#			$Player.rotate_y(-0.1)
		pass
	pass
	

func _on_VRMain_controller_pressed():
	#print("Main: Controller pressed")
	$Player.accelerate()
	pass


func _on_VRMain_controller_released():
	#print("Main: Controller released")
	$Player.brake()
	pass


func _on_Player_entity_left_area(body):
	if "IS_TREE" in body:
		$Level.place_tree(body)
#	body.queue_free()
	pass
