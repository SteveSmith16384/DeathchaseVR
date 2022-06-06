extends CSGSphere


func _ready():
	self.visible = self.visible and not Globals.RELEASE_MODE
	pass

func _process(_delta):
#	if self.global_transform.origin.y != 0:
#		var owner = self.owner
#		if owner.name != "Heli":
#			print("Here! " + owner.name)
		
	pass
