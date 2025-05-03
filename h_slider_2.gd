extends HSlider


func _on_drag_ended(value_changed: bool) -> void:
	var player_node_path = %Player
	print(player_node_path)
