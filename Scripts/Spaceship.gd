# Movement where the character rotates and moves forward or backward.
extends KinematicBody2D

onready var bulletscene = preload("res://Scenes/Bullet.tscn")

const THRUST : float = 10.0
const MAX_SPEED : float = 400.0
const ROTATION_SPEED : float = 5.0 * 60

var velocity = Vector2(0, 0)
var reload_time = 0
var fire_rate=0.2
var shoot_rotation = 0

func _physics_process(delta):
		
	var closest_distance = 10000
	var enemy_near = false
	for body in $Area2D.get_overlapping_bodies():
		if position.distance_to(body.position)<closest_distance:
			#look_at(body.position)
			$Gun.global_rotation = PI+position.angle_to_point(body.position)
			shoot_rotation = $Gun.global_rotation
			closest_distance = position.distance_to(body.position)
			enemy_near = true
	
	$EngineParticles.emitting=false	
	reload_time -= delta
	if GlobalVariables.player_is_alive:
		
		if reload_time < 0:
			reload_time = fire_rate
			if enemy_near:
				shoot()
		
		
		if Input.is_action_pressed("move_left"):
			var acceleration : Vector2
			acceleration = Vector2(-THRUST, 0)
			velocity += acceleration
			$EngineParticles.emitting=true
			
		if Input.is_action_pressed("move_right"):
			var acceleration : Vector2
			acceleration = Vector2(THRUST, 0)
			velocity += acceleration
			$EngineParticles.emitting=true
			

		# get acceleration if thrust is pressed
		if Input.is_action_pressed("move_up"):
			var acceleration : Vector2
			acceleration = Vector2(0, -THRUST)
			velocity += acceleration
			$EngineParticles.emitting=true
			
		if Input.is_action_pressed("move_down"):
			var acceleration : Vector2
			acceleration = Vector2(0, +THRUST)
			velocity += acceleration
			$EngineParticles.emitting=true

	velocity *= 0.98
	


	if velocity.length() > MAX_SPEED:
		velocity = velocity.normalized() * MAX_SPEED
	
	var collision = move_and_collide(velocity * delta)
	if collision:
		if not collision.collider.is_in_group("enemies"):
			pass
		velocity = velocity.bounce(collision.normal)
	
	#rotation = cos(velocity.normalized().x) + sin(velocity.normalized().y)
	look_at(transform.origin + velocity)
func shoot():
	var bullets = [0,10,-10, 180]
	for bulletdirection in bullets:
		var bullet =  bulletscene.instance()	
		bullet.start($Gun/Muzzle.global_position, shoot_rotation - deg2rad(bulletdirection))
		get_parent().add_child(bullet)
		
