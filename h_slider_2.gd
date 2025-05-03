extends HSlider
@onready var player_node_path = %Player

func _process(_delta: float) -> void:
	player_node_path.mouse_sensitivity = value
