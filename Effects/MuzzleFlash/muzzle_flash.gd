class_name MuzzleFlash
extends Node3D


@export var flash_time: float = 0.05
var _flash_timer : float = 0.0
@export var light : OmniLight3D
@export var emitters : Array[GPUParticles3D] = []
@export var gunshotAudio : AudioStreamPlayer3D


func _process(delta: float) -> void:
	if _flash_timer > 0:
		_flash_timer -= delta
		if _flash_timer <= 0:
			end_flash();
		
func start_flash() -> void:
	light.visible = true
	gunshotAudio.pitch_scale = randf_range(0.9, 1.1) # Add random variation to sound pitch
	gunshotAudio.play()
	for emitter in emitters:
		emitter.emitting = true
	_flash_timer = flash_time

func end_flash() -> void:
	light.visible = false
	for emitter in emitters:
		emitter.emitting = false
