extends Camera3D

func _ready() -> void:
	$".".position = Vector3(195,2.1,-120)

func _process(delta: float) -> void:
	if $".".position.z < -70:
		$".".position.z += 0.25
