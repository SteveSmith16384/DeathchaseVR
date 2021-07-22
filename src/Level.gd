extends Spatial

var tree_class = load("res://Tree.tscn")
func _process(delta):
	pass


func _on_Timer_timeout():
	var num_trees = self.get_child_count()
	if num_trees < 4:
		create_tree()
		pass
	pass


func create_tree() -> void:
	var tree = tree_class.new_instance();
	
	
	
	self.add_child(tree)
	pass
