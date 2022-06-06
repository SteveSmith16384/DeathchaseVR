#class_name Tree
extends Spatial

const IS_TREE = true


func _on_Area_area_entered(area):
	#var name = area.name
	if area.name == "CollisionArea":
		var owner = area.get_parent_spatial()
		if owner.has_method("hit_tree"):
			owner.hit_tree()
		pass
	pass
	
