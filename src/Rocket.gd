extends Spatial

const SPEED = 13

onready var jet_class = preload("res://RocketJet.tscn")

var vr_main
var main : Main
#var player# : Player
var move_dir = Vector3(0, 0, 1) # Gets overwritten with player's dir

func _ready():
	main = get_tree().get_root().get_node("Main")
	#player = main.get_node("Player")
	vr_main = main.get_node("Player/VRMain")

	pass
	
	
func _process(delta):
	var controller_basis : Basis = vr_main.get_controller_orientation()
	var new_dir = controller_basis.z * -1
	new_dir = move_dir.normalized().slerp(new_dir, 0.2)
	move_dir = new_dir
	move_dir.y = 0
	
	var offset = move_dir * (SPEED * delta)
	var new_pos = self.translation + offset
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
