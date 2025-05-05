extends Node3D

func _ready():
	# Make sure to not await during _ready.
	fsaf.call_deferred()

func fsaf():
	await get_tree().create_timer(30).timeout
	queue_free()
