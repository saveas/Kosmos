# Movement where the character rotates and moves forward or backward.
extends KinematicBody2D

onready var bulletscene = preload("res://Scenes/Bullet.tscn")

const THRUST : float = 10.0
const MAX_SPEED : float = 400.0
const ROTATION_SPEED : float = 5.0 * 60

var velocity = Vector2(0, 0)


func _physics_process(delta):
	
	$EngineParticles.emitting=false	
	
	if Input.is_action_just_pressed("shoot"):
		shoot()
	
	if Input.is_action_pressed("ui_left"):
		rotation_degrees -= delta * ROTATION_SPEED
		
	if Input.is_action_pressed("ui_right"):
		rotation_degrees += delta * ROTATION_SPEED


	# get acceleration if thrust is pressed
	if Input.is_action_pressed("ui_up"):
		var acceleration : Vector2
		acceleration = Vector2(0, -THRUST).rotated(deg2rad(rotation_degrees))
		velocity += acceleration
		$EngineParticles.emitting=true

	velocity *= 0.98

	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
	
func shoot():
	var bullets = [90,100,80]
	for bulletdirection in bullets:
		var bullet =  bulletscene.instance()	
		bullet.start($Muzzle.global_position, rotation - deg2rad(bulletdirection))
		get_parent().add_child(bullet)
