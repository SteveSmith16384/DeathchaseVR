extends Spatial

var player : Player

onready var tree_class = preload("res://Tree.tscn")

func _ready():
	var main = get_tree().get_root().get_node("Main")
	player = main.get_node("Player")
	pass
	
	
func _process(delta):
	pass


func _on_Timer_timeout():
	var num_trees = self.get_child_count()
	#if num_trees < 10:
	create_tree()
	#	pass
	pass


func create_tree() -> void:
	var pos : Vector3  = player.get_random_position()
	
	var tree = tree_class.instance();
	tree.translation.x = pos.x
	tree.translation.z = pos.z
	
	self.add_child(tree)
	pass
