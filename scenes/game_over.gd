extends Node2D



func _input(event):
	if event.is_pressed():
		Transition.change_scene_to_file("res://scenes/mainmenu.tscn")
