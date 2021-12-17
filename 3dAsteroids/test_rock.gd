extends RigidBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_linear_velocity(Vector3(0,0,5.0))


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(global_transform.origin.z)
	if global_transform.origin.z >= 5:
		print("Out of Bounds")
		queue_free()