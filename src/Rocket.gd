extends KinematicBody

var direction# = Vector3(0, 0, -1)

func _ready():
	pass # Replace with function body.


func _process(delta):
	self.move_and_slide(direction * 8, Vector3.UP)
	pass


func _on_Timer_timeout():
	self.queue_free()
	pass
	
