extends RigidBody

onready var score = get_parent().get_node("./UI/Score")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	var rand = RandomNumberGenerator.new()
	rand.randomize()
	var vel_x = rand.randf_range(-0.2,0.2)
	var vel_y = rand.randf_range(-0.2,0.2)
	set_linear_velocity(Vector3(vel_x, vel_y, 5.0))
	
	var rotation = Vector3(rand.randf_range(-1.0,1.0),
	rand.randf_range(-1.0,1.0),
	rand.randf_range(-1.0,1.0)
	)
	
	set_angular_velocity(rotation)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#print(global_transform.origin.z)
	if global_transform.origin.z >= 1.1:
		print("Out of Bounds")
		queue_free()
	

func _on_Area_body_entered(body):
	if body is StaticBody:
		pass
		queue_free()
		body.queue_free()
		var int_score = int(score.text)
		int_score += 1
		score.text = str(int_score)
		
	if body is KinematicBody:
		print("Spaceship hit")
		body.queue_free()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	#body.queue_free()
