extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var camera = get_node("../Camera")
var vel = Vector3()
# Called when the node enters the scene tree for the first time.
var blast = preload("res://laser_blast_basic.tscn")
var fired_blast
var targeted_asteroid
var ammo = 20
var timer = Timer.new()
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
	
	timer.connect("timeout", self, "_reload")
	add_child(timer)
	timer.set_wait_time(1)
	timer.start()

func _reload():
	if ammo < 20:
		ammo += 1

func _fire():
	if ammo > 0:
		ammo -= 1
		fired_blast = blast.instance()
		fired_blast.global_transform.origin = $Position3D.global_transform.origin
		
		get_parent().add_child(fired_blast)
	timer.set_wait_time(0.25)
	#print("Timer : ", 5-rounds/10000)
	timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	
	if Input.is_action_just_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CONFINED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CONFINED)
			
	if Input.is_action_just_pressed("fire"):


		fired_blast = blast.instance()


		fired_blast.global_transform.origin = $Position3D.transform.origin

		add_child(fired_blast)
		
	if Input.is_action_pressed("fire"):
		_fire()
		
	
		
	var position2D = get_viewport().get_mouse_position()
	
	var dropPlane = Plane(Vector3(0,0,10), -2)
	var position3D = dropPlane.intersects_ray(
		camera.project_ray_origin(position2D),
		camera.project_ray_normal(position2D)
	)
	
	
	transform.origin = transform.origin.linear_interpolate(
		Vector3((position3D.x - transform.origin.x) * 2, (position3D.y - transform.origin.y) * 2, 0), 
		delta
		)
	
	#vel = Vector3(position3D.x - transform.origin.x, position3D.y - transform.origin.y, 0)
	#vel = move_and_slide(vel)
	
