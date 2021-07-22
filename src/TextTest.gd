extends CSGBox

# The box's label.
onready var label: Label = get_node("Label")
# The player's camera.
onready var camera: Camera = get_viewport().get_camera()

# Aligns the position of the label to always face the camera.
#
# `point` - The position to align the label to.
func position_label(point: Vector3):
	var offset = Vector2(label.get_size().x / 2, 0)
	label.rect_position = camera.unproject_position(point) - offset
	

# Every frame we check to see if the label is behind the camera or the label is
# out of the render distance and if so we return early. Otherwise, we position
# the label on the cube so that it's always facing the camera.
#
# `_delta` - The difference in time between the last frame and the current frame.
func _process(_delta):
	var pos: Vector3 = global_transform.origin
	
	# If the point is behind the camera we hide the label and return early.
	if camera.is_position_behind(pos): return
	
	position_label(pos)
	
	
