extends KinematicBody2D
onready var explosionscene = preload("res://Scenes/Explosion.tscn")

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
			explosion.emitting=true
			get_parent().add_child(explosion)			
			collision.collider.queue_free()
			self.queue_free()
		velocity = velocity.bounce(collision.normal)
		if collision.collider.has_method("hit"):
			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
