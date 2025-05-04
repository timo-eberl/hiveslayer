extends Camera3D

func _ready() -> void:
	$".".position = Vector3(195,2.1,-70)

func _process(delta: float) -> void:
	if $".".position.z < 0:
		$".".position.z += 0.25
