extends Spatial

onready var player = get_node("player_ship")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var rounds = 0
var timer = Timer.new()
var rock = preload("res://test_rock.tscn")
var rand = RandomNumberGenerator.new()
var positions = [
	$Position3D, $Position3D2, $Position3D3, 
	$Position3D4, $Position3D5, $Position3D6, 
	$Position3D7, $Position3D8, $Position3D9
	]
# Called when the node enters the scene tree for the first time.
func _ready():
	var textScore = $UI/Score
	print(textScore.text)
	
	var positions = [
	$Position3D, $Position3D2, $Position3D3, 
	$Position3D4, $Position3D5, $Position3D6, 
	$Position3D7, $Position3D8, $Position3D9
	]
	var spawner
	for p in positions:
		#print(p)
		spawner = rock.instance()
		spawner.global_transform = p.global_transform
		add_child(spawner)
	
	timer.connect("timeout", self, "_spawn_new_asteroid")
	add_child(timer)
	timer.set_wait_time(5)
	timer.start()
	
	rand.randomize()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	rounds += 1
	var ammo_string = ""
	if player != null: #issue when dying needs to be fixed
		for i in range(0, player.ammo):
			ammo_string+="+"
	
	
	$UI/Ammo.text = ammo_string
	#print(rounds)
func _spawn_new_asteroid():
	for i in range(0,3):
		var positions = [
		$Position3D, $Position3D2, $Position3D3, 
		$Position3D4, $Position3D5, $Position3D6, 
		$Position3D7, $Position3D8, $Position3D9
		]
		var spawner
		spawner = rock.instance()
		spawner.global_transform = positions[rand.randi_range(0,8)].global_transform
		add_child(spawner)
	timer.set_wait_time(5 - rounds/10)
	#print("Timer : ", 5-rounds/10000)
	timer.start()
