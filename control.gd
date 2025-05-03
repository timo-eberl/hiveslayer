extends Control

func _on_trigger_button_pressed():
	get_tree().change_scene_to_file("res://control.tscn")


func _on_button_pressed():
	get_tree().change_scene_to_file("res://world.tscn") # Replace with function body.
