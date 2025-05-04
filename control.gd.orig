extends Control

@onready var player = %Player

#Checks if the game has started
var started := false

#Checks if the player is allowed to rotate
#Should probably rename it to pause.
var pause := false

func _on_trigger_button_pressed():
	get_tree().change_scene_to_file("res://control.tscn")

func _on_button_pressed():
	player.enabled = true
	started = true
	pause = true
	$".".visible = false
<<<<<<< HEAD


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	$"ColorRect".visible = false
	print($"ColorRect".mouse_filter)
	
=======
>>>>>>> ad042147a989f20238316714bc39199d1efe486b
