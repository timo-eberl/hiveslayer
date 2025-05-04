extends Control

@onready var player = %Player
@onready var playerCamera = %Camera

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
	playerCamera.make_current()
	

	
