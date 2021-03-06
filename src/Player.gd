class_name Player
extends Spatial

const MAX_SPEED = 30

onready var rocket_class = preload("res://Rocket.tscn")

signal entity_left_area

var main
var player_start_y : float
var accel = false
var shooting = false
var speed: float = 0
var move_dir : Vector3 = Vector3(0, 0, 1)


func _ready():
	main = get_tree().get_root().get_node("Main")
	player_start_y = 0
	pass


func _process(delta):
	translation.y = self.player_start_y
	
	if Globals.TEST_GAME:
		self.accelerate()
#		self.rotate_y(1 * delta)
	
	if main.in_game:
		if accel:
			shooting = true
			speed += 5 * delta
			if speed > MAX_SPEED:
				speed = MAX_SPEED
				Globals.score += delta * 2
			if $Audio_Engine.playing == false:
				$Audio_Engine.play()
		else:
			shooting = false
			speed -= 10 * delta
			if speed < 0:
				speed = 0

	# Engine sound
	var scale:float = speed/MAX_SPEED
	scale = scale / 2
	$Audio_Engine.pitch_scale = scale + 0.5
	pass


func accelerate():
	if main.in_game == false:
		main.start_game()
	accel = true
	pass
	
	
func brake():
	accel = false
	pass


func _on_RemovalArea_area_exited(area : Area):
	var owner = area.get_parent_spatial()
	emit_signal("entity_left_area", owner)
	pass


func get_random_global_spawn_position() -> Vector3:
	var idx = Globals.rnd.randi_range(1, $SpawnPoints.get_child_count())
	return $SpawnPoints.get_node("Position3D_" + str(idx)).get_global_transform().origin


func _on_ShootTimer_timeout():
	if shooting || Globals.AUTO_SHOOT:
		var rocket = rocket_class.instance();
		rocket.translation = $Muzzle.get_global_transform().origin
		rocket.translation.y = 0
		rocket.move_dir = move_dir
		main.add_child(rocket)
	pass


func hit_tree():
	$Audio_Engine.stop()
	$Audio_Crash.play()
	speed = 0
	Globals.lives -= 1
	if Globals.lives <= 0:
		main.end_of_game()
	pass


func _on_Audio_Engine_finished():
	if speed > 0:
		$Audio_Engine.play()
	pass
