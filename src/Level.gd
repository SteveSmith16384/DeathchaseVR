extends Spatial

var player : Player

onready var tree_class = preload("res://Tree.tscn")

func _ready():
	var main = get_tree().get_root().get_node("Main")
	player = main.get_node("Player")
	pass
	
	
func _on_Timer_timeout():
	var num_trees = self.get_child_count()
	if num_trees < Globals.NUM_TREES:
		if player.speed > 0: # Only if player moving otherwise trees will appear on top of each other
			create_tree()
		pass
	pass


func create_tree() -> void:
	var tree = tree_class.instance();
	place_tree(tree)
	self.add_child(tree)
	pass
	
	
func place_tree(tree):
	var pos : Vector3  = player.get_random_global_spawn_position()
	
	var level_global : Vector3 = self.global_transform.origin
	tree.translation.x = pos.x - level_global.x
	tree.translation.y = 0
	tree.translation.z = pos.z - level_global.z
	pass
