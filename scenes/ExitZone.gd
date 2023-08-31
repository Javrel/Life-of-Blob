extends Area2D

		


func _on_body_entered(body):
	if body.name == "Blob":
		body.controllable = false
		#  do stuff then transition
		Transition.change_scene_to_file("res://scenes/level2.tscn")
