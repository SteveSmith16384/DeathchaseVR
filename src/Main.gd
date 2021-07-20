extends Spatial


func _ready():
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
