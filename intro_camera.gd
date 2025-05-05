extends Camera3D

func _ready() -> void:
	$".".position = Vector3(195,12.3,-170)

func _process(delta: float) -> void:
	#195
	#257
	if $".".position.x <= 257:
		$".".position.x += 0.25
