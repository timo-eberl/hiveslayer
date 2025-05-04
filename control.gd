extends Control

@onready var player = %Player
@onready var playerCamera = %Camera
@onready var timer = %Timer
@onready var time_Label = %TimeSurvived
@onready var visible_timer = %CanvasTime

#Checks if the game has started
var started := false
var total_time_in_seconds = 0

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
	timer.start()
	visible_timer.visible = true
	

func pauze_game():
	player.enabled = false
	$".".visible = true
	

	


func _on_timer_timeout() -> void:
	total_time_in_seconds += 1
	var m = int(total_time_in_seconds/60.0)
	var s = total_time_in_seconds - m * 60
	time_Label.text = 'Seconds survived: %02d:%02d' % [m, s]
	
	pass # Replace with function body.
