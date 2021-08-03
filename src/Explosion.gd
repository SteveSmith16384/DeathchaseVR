extends Spatial

var colors = [Color(1.0, 0.0, 0.0, 1.0),
		  Color(0.0, 1.0, 0.0, 1.0),
		  Color(0.0, 0.0, 1.0, 0.0)]

func _ready():
	$AudioStreamPlayer.play()
	pass
	
	
func _on_Timer_timeout():
	queue_free()
	pass


func _on_ChangeColourTimer_timeout():
	var idx = Globals.rnd.randi_range(0, colors.size()-1)
	$Sprite3D.modulate = colors[idx]
	pass
