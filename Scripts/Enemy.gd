extends KinematicBody2D
var velocity: Vector2

func _ready():
	add_to_group("enemies")
	print(get_tree().get_nodes_in_group("SpaceShip")[0].position)


func _physics_process(delta):
	velocity = (get_tree().get_nodes_in_group("SpaceShip")[0].position - position).normalized()
	move_and_collide(velocity)
