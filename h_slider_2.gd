extends HSlider
@onready var player_node_path = %Player

func _on_drag_ended(value_changed: bool) -> void:
	print(player_node_path)
