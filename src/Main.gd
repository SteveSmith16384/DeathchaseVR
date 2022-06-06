class_name Main
extends Spatial

var biker_class = preload("res://EnemyBiker.tscn")	
var tank_class = preload("res://Tank.tscn")	
var heli_class = preload("res://Heli.tscn")	
var expl_class = preload("res://Explosion.tscn")	

var daytime = true

func _ready():
	# Preload
#	self.small_explosion(self)

#	var env = $Player/VRMain/ARVROrigin/ARVRCamera.environment
#	var sky = env.get("background_sky")
#	$Tween.interpolate_property(sky ,"sky_top_color", sky.sky_top_color, Color.cyan, 3, Tween.TRANS_LINEAR)
#	$Tween.start()
	pass


func _process(delta):
	if $Player.speed > 0:
		var controller_basis : Basis = $Player/VRMain.get_controller_orientation()
		var new_dir = controller_basis.z * -1
		new_dir = $Player.move_dir.normalized().slerp(new_dir, 0.1)
		$Player.move_dir = new_dir
		$Player.move_dir.y = 0
		
		# Rotate the player, otherwise we're rotating the level in the distance
		var global_pos = $Player.global_transform.origin
		var pos = global_pos + ($Player.move_dir * 10)
		pos.y = $Player.translation.y
		$Player.look_at(pos, Vector3.UP)

		$Level.translation += $Player.move_dir * ($Player.speed * delta * -1)
	pass
	

func small_explosion(spatial):
	var i = expl_class.instance()
	# Add to level since that's what moves!
	$Level.add_child(i)
	i.translation = spatial.global_transform.origin - $Level.translation
	pass
	
	
func _on_VRMain_controller_pressed():
	#print("Main: Controller pressed")
	$Player.accelerate()
	pass


func _on_VRMain_controller_released():
	#print("Main: Controller released")
	$Player.brake()
	pass


func _on_Player_entity_left_area(body):
	if "IS_TREE" in body:
		$Level.place_tree(body)
	pass


func biker_killed():
	Globals.num_bikers -= 1
	if Globals.num_bikers <= 0:
		$NextLevelTimer.start()
	pass


func next_level():
	Globals.NUM_TREES += 3
	daytime = not daytime
	var env = $Player/VRMain/ARVROrigin/ARVRCamera.environment
	#var sky = env.get("background_sky")
	if daytime:
#			$Tween.interpolate_property(sky ,"sky_top_color", sky.sky_top_color, Color.cyan, 3, Tween.TRANS_LINEAR)
#			$Tween.start()
#			$Tween2.interpolate_property(sky ,"sky_horizon_color", sky.sky_top_color, Color.white, 3, Tween.TRANS_LINEAR)
#			$Tween2.start()
		env.background_sky.sky_top_color = Color(0, 1, 1)
		env.background_sky.sky_horizon_color = Color(1, 1, 1)
	else:
#			$Tween.interpolate_property(sky ,"sky_top_color", sky.sky_top_color, Color.black, 3, Tween.TRANS_LINEAR)
#			$Tween.start()
#			$Tween2.interpolate_property(sky ,"sky_horizon_color", sky.sky_top_color, Color.black, 3, Tween.TRANS_LINEAR)
#			$Tween2.start()
		env.background_sky.sky_top_color = Color(0, 0, 0)
		env.background_sky.sky_horizon_color = Color(0, 0, 0)

	var i = biker_class.instance()
	i.blue = true
	i.init()
	add_child(i)
	i = biker_class.instance()
	i.blue = false
	i.init()
	add_child(i)
	
	Globals.level += 1
	pass


func _on_TankHeliTimer_timeout():
	if Globals.level <= 1:
		return
		
	if Globals.rnd.randi_range(1, 2) == 1:
		if self.has_node("Tank") == false:
			var i = tank_class.instance()
			add_child(i)
	else:
		if self.has_node("Heli") == false:
			var i = heli_class.instance()
			add_child(i)
	pass


func _on_NextLevelTimer_timeout():
	$NextLevelTimer.stop()
	next_level()
	pass
