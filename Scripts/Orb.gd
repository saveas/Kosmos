extends KinematicBody2D

var velocity = Vector2()
var speed = 600

func _ready():
	add_to_group("orbs")

func _physics_process(delta):
	if position.distance_to(get_tree().get_nodes_in_group("SpaceShip")[0].position)<100:
		velocity = (get_tree().get_nodes_in_group("SpaceShip")[0].position - position).normalized()
		var _collision = move_and_collide(velocity * delta * speed)
	if position.distance_to(get_tree().get_nodes_in_group("SpaceShip")[0].position)<10:
		queue_free()
