extends Spatial

const SPEED = 13

onready var jet_class = preload("res://RocketJet.tscn")

var main
var move_dir

func _ready():
	main = get_tree().get_root().get_node("Main")
	pass
	
	
func _process(delta):
	var new_pos = self.translation + (move_dir * SPEED * delta)
	self.translation = new_pos
	pass


func _on_Timer_timeout():
	self.queue_free()
	pass
	

func hit_tree():
	# todo
	pass


func _on_JetTimer_timeout():
	var jet = jet_class.instance();
	jet.translation = self.global_transform.origin
	main.add_child(jet)
	pass


func _on_CollisionArea_area_entered(area):
	var owner : Spatial = area.get_parent_spatial()
	if owner.has_method("hit_by_rocket"):
		owner.hit_by_rocket()
	pass
