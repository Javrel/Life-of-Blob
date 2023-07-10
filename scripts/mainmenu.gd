extends Node2D


export var mainGameScene : PackedScene

var menu_fade_out = false

# Called when the node enters the scene tree for the first time.
func _ready():
	Transition.transition_in()

func play_hover():
	$Audio/Hover.play()

func play_select():
	$Audio/Select.play()
	
func _on_NewGame1_mouse_entered():
	play_hover()
	
func _on_NewGame2_mouse_entered():
	play_hover()

func _on_OptionsButton_mouse_entered():
	play_hover()

func _on_QuitButton_mouse_entered():
	play_hover()

func _on_QuitButton_button_down():
	play_select()
	Transition.change_scene("")
	
func _on_OptionsButton_button_down():
	play_select()
	Transition.change_scene("res://options.tscn")

func _on_NewGame2_button_down():
	play_select()
	Transition.change_scene("res://level2.tscn")

func _on_NewGame1_button_down():
	play_select()
	Transition.change_scene("res://level1.tscn")


