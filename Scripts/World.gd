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
	var enemy =  Enemy.instance()	
	var camera_pos = get_node("Spaceship/Camera2D").get_camera_position()
	enemy.position=Vector2(rng.randi_range(camera_pos.x-300, camera_pos.x+300),rng.randi_range(camera_pos.y-300, camera_pos.y+300))
	get_parent().add_child(enemy)
	
