class_name SoundEffect3D
extends AudioStreamPlayer3D

static func SoundPlayPosition(parent, position: Vector3, soundStream: AudioStreamWAV, pitch: float = 1.0, volume: float = 0):
	var soundEffectScene = preload("res://Audio/SoundEffect3D.tscn")
	
	var soundEffect : AudioStreamPlayer3D = soundEffectScene.instantiate()
	parent.add_child(soundEffect)
	soundEffect.global_position = position
	soundEffect.stream = soundStream
	soundEffect.pitch_scale = pitch
	soundEffect.volume_db = volume
	soundEffect.play()
	return soundEffect
	
func _process(delta: float) -> void:
	if !playing:
		queue_free()
	
