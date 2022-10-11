extends CPUParticles2D

var timer = Timer.new()

func _ready():
	timer.connect("timeout",self,"destroy")
	timer.wait_time = 3
	add_child(timer)
	timer.start()

func destroy():
	queue_free()
