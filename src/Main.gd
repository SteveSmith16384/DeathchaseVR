extends Spatial

func _ready():
	pass


func _process(delta):
	#move_player(delta)
	move_level(delta)
	pass
	
	
func move_level(delta):
	if $Player.speed > 0:
		var controller_basis : Basis = $Player/VRMain.get_controller_orientation()
		var new_dir = controller_basis.z * -1 # scs new -1
		new_dir = $Player.move_dir.normalized().slerp(new_dir, 0.1)
		$Player.move_dir = new_dir
		$Player.move_dir.y = 0
		
		# Rotate the player, otherwise we're rotating the level in the diatance
		var global_pos = $Player.global_transform.origin
		var pos = global_pos + ($Player.move_dir * 10)
		pos.y = $Player.translation.y
		$Player.look_at(pos, Vector3.UP)

		# Move the level
		#$Level.move_and_slide($Player.direction * -$Player.speed, Vector3.UP)
		$Level.translation += $Player.move_dir * ($Player.speed * delta * -1)
	pass
	

func move_player(delta):
	if $Player.speed > 0:
		var controller_basis : Basis = $Player/VRMain.get_controller_orientation()
		var new_dir = controller_basis.z * -1
		new_dir = $Player.move_dir.normalized().slerp(new_dir, 0.1)
		$Player.move_dir = new_dir
		$Player.move_dir.y = 0
		
		var global_pos = $Player.global_transform.origin
		var pos = global_pos + ($Player.move_dir * 10)
		pos.y = $Player.translation.y
		$Player.look_at(pos, Vector3.UP)

		# Move the level
		#$Level.move_and_slide($Player.direction * -$Player.speed, Vector3.UP)
		$Level.translation += $Player.move_dir * (-$Player.speed * delta)
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
