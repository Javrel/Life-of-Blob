extends Node2D


export var mainGameScene : PackedScene


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body. 

func _on_QuitButton_button_up():
	get_tree().quit()


func _on_NewGame2_button_up():
	get_tree().change_scene("res://level2.tscn")


func _on_NewGame1_button_up():
	get_tree().change_scene("res://level1.tscn")
