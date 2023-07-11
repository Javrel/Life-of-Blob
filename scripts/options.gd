extends Node2D


func _ready():
	pass 

func play_select():
	$Audio/Select.play()

func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value) 


func _on_back_button_down():
	play_select()
	Transition.change_scene("res://scenes/mainmenu.tscn")


func _on_VolumeSlider_ready():
	$MenuContainer/VBoxContainer/VBoxContainer/MarginContainer/VolumeSlider.value = AudioServer.get_bus_volume_db(
		AudioServer.get_bus_index("Master")
	)
