extends StaticBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	transform.origin.z -= 0.25
	
	
	#print(global_transform.origin.z)
	#print(linear_velocity)
	if global_transform.origin.z <= -25:
		
		queue_free()
