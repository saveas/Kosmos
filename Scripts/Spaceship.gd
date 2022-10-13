# Movement where the character rotates and moves forward or backward.
extends KinematicBody2D

onready var bulletscene = preload("res://Scenes/Bullet.tscn")

const THRUST : float = 10.0
const MAX_SPEED : float = 400.0
const ROTATION_SPEED : float = 5.0 * 60

var velocity = Vector2(0, 0)
var reload_time = 0
var fire_rate=0.2

func _physics_process(delta):
	
	$EngineParticles.emitting=false	
	reload_time -= delta
	if Input.is_action_pressed("shoot") and reload_time < 0:
		reload_time = fire_rate
		shoot()
	
	if Input.is_action_pressed("move_left"):
		rotation_degrees -= delta * ROTATION_SPEED
		
	if Input.is_action_pressed("move_right"):
		rotation_degrees += delta * ROTATION_SPEED
		

	# get acceleration if thrust is pressed
	if Input.is_action_pressed("move_up"):
		var acceleration : Vector2
		acceleration = Vector2(0, -THRUST).rotated(deg2rad(rotation_degrees))
		velocity += acceleration
		$EngineParticles.emitting=true
		
	if Input.is_action_pressed("move_down"):
		var acceleration : Vector2
		acceleration = Vector2(0, +THRUST).rotated(deg2rad(rotation_degrees))
		velocity += acceleration
		$EngineParticles.emitting=true

	velocity *= 0.98
	
	#$Camera2D.zoom = Vector2(2,2)

	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		velocity = velocity.bounce(collision.normal)
		if collision.collider.is_in_group("enemies"):	
			GlobalVariables.player_health -= 1

	
func shoot():
	var bullets = [90,100,80, 270]
	for bulletdirection in bullets:
		var bullet =  bulletscene.instance()	
		bullet.start($Muzzle.global_position, rotation - deg2rad(bulletdirection))
		get_parent().add_child(bullet)
		
