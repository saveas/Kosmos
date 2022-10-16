extends KinematicBody2D
var velocity: Vector2
var speed = 60
var health = 1
var state = "idle"

func _ready():
	$AnimatedSprite.play(state)
	add_to_group("enemies")
	var _body_entered_signal = $Area2D.connect("body_entered", self, "_collision_body_entered")
	var _body_exited_signal =$Area2D.connect("body_exited", self, "_collision_body_exited")

func _collision_body_entered(body):
	if body.is_in_group("SpaceShip"):
		state = "attack"
		$AnimatedSprite.play(state)

func _collision_body_exited(body):
	if body.is_in_group("SpaceShip"):
		state = "idle"
		$AnimatedSprite.play(state)

func _physics_process(delta):
	var target = get_tree().get_nodes_in_group("SpaceShip")[0]
	var angle = (target.position - self.global_position).angle()
	self.global_rotation = lerp_angle(self.global_rotation, angle, 10*delta)
	velocity = velocity.move_toward((target.position - position).normalized(),1)
	var _collision = move_and_collide(velocity * delta * speed)
	if state == "attack":
		GlobalVariables.player_health -= 0.1
		
	if GlobalVariables.player_health<=0:
		get_tree().get_nodes_in_group("SpaceShip")[0].visible = false
		GlobalVariables.player_is_alive = false

func reduce_health(amount):
	health -= amount

func set_velocity(newVelocity):
	velocity=newVelocity
	

