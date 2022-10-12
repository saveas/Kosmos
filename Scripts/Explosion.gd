extends CPUParticles2D
onready var AudioPlayer = preload("res://Scenes/AudioStreamPlayer2D.tscn")
var audio_stream = preload("res://Assets/explosion.wav")
var timer = Timer.new()

func _ready():
	timer.connect("timeout",self,"destroy")
	timer.wait_time = 3
	add_child(timer)
	timer.start()
	var sound =  AudioPlayer.instance()
	get_parent().add_child(sound)
	sound.play_sound(audio_stream)
	
func destroy():
	queue_free()
