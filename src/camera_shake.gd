class_name CameraShake
extends Camera3D

var shake_time_left: float = 0.0 # Time remaining for the shake
var shake_offset: Vector3 = Vector3.ZERO # Current shake offset
var shake_magnitude: float # Max shake amount (in world units)

@onready var current_rotation := Vector3(0,0,0)

func shake(duration: float, magnitude: float):
	shake_time_left = duration
	shake_magnitude = magnitude
	
func _process(delta: float) -> void:
	# Apply camera shake offset
	if shake_time_left > 0:
		shake_offset = Vector3(
			randf_range(-shake_magnitude, shake_magnitude),
			randf_range(-shake_magnitude, shake_magnitude),
			randf_range(-shake_magnitude, shake_magnitude)
		)
		shake_time_left -= delta
	else:
		shake_offset = Vector3.ZERO
	
	self.h_offset = shake_offset.y
	self.v_offset = shake_offset.x
	
	rotation = current_rotation + shake_offset * 0.7
