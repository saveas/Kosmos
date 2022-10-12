extends KinematicBody2D
onready var explosionscene = preload("res://Scenes/Explosion.tscn")
onready var orbscene = preload("res://Scenes/Orb.tscn")

var speed = 1000
var velocity = Vector2()

func start(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	var collision = move_and_collide(velocity * delta)
	if collision:
		if collision.collider.is_in_group("enemies"):
			var explosion =  explosionscene.instance()	
			explosion.position=collision.collider.position
			explosion.rotation=rotation
			explosion.emitting=true
			get_parent().add_child(explosion)			
			collision.collider.queue_free()
			queue_free()
			var orb =  orbscene.instance()	
			get_parent().add_child(orb)
			orb.position=collision.collider.position
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()
			
	var camera_pos = get_parent().get_node("Spaceship/Camera2D").get_camera_position()
	if position.distance_to(camera_pos)>600:
		queue_free()


