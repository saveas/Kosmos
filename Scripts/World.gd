extends Node2D

onready var Enemy = preload("res://Scenes/Enemy.tscn")
var timer = Timer.new()
var rng = RandomNumberGenerator.new()

func _ready():
	timer.connect("timeout",self,"spawn_enemy")
	timer.wait_time = 1
	add_child(timer)
	timer.start()

func spawn_enemy():
	var is_valid_spawn_pos = false
	var enemy =  Enemy.instance()	
	var camera_pos = get_node("Spaceship/Camera2D").get_camera_position()
	while not is_valid_spawn_pos:
		enemy.position=Vector2(rng.randi_range(camera_pos.x-600, camera_pos.x+600),rng.randi_range(camera_pos.y-600, camera_pos.y+600))
		if enemy.position.distance_to(camera_pos)>400:
			get_parent().add_child(enemy)
			is_valid_spawn_pos = true
	
