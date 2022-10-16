extends Node2D


# Declare member variables here. Examples:
func _input(event):
	if (event is InputEventKey or event is InputEventScreenTouch) and event.pressed:
		var _start = get_tree().change_scene("res://Scenes/World.tscn")

func _process(_delta):
	$Camera2D.position.x += 1
