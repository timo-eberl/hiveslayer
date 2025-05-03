extends Node

@export var lifetimeSeconds : float = 1.0

func _process(delta: float) -> void:
	lifetimeSeconds -= delta
	if lifetimeSeconds <= 0.0:
		queue_free()
