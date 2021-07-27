extends Spatial

const SPEED = 16#160

var move_dir# = Vector3(0, 0, -1)

func _ready():
	pass # Replace with function body.


func _process(delta):
	var new_pos = self.translation + (move_dir * SPEED * delta)
	self.translation = new_pos
	
	#self.move_and_slide(move_dir * SPEED, Vector3.UP)
	pass


func _on_Timer_timeout():
	self.queue_free()
	pass
	

func hit_tree():
	pass
