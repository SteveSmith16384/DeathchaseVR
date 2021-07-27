extends KinematicBody

const SPEED = 16

var direction# = Vector3(0, 0, -1)

func _ready():
	pass # Replace with function body.


func _process(delta):
	self.move_and_slide(direction * SPEED, Vector3.UP)
	pass


func _on_Timer_timeout():
	self.queue_free()
	pass
	
