extends KinematicBody2D
var velocity: Vector2
var speed = 60
var health = 3

func _ready():
	add_to_group("enemies")


func _physics_process(delta):
	velocity = velocity.move_toward((get_tree().get_nodes_in_group("SpaceShip")[0].position - position).normalized(),1)
	var _collision = move_and_collide(velocity * delta * speed)

func reduce_health(amount):
	health -= amount

func set_velocity(newVelocity):
	velocity=newVelocity
