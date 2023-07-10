extends Node2D


func _ready():
	pass # Replace with function body.

func play_select():
	$Audio/Select.play()

func _on_VolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value) # Replace with function body.


func _on_back_button_down():
	play_select()
	Transition.change_scene("res://mainmenu.tscn") # Replace with function body.


func _on_VolumeSlider_ready():
	$MenuContainer/VBoxContainer/VBoxContainer/MarginContainer/VolumeSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
