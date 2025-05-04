extends HSlider

#@export
#var bus_index: int

#func _ready() -> void:
#	print(bus_name)
#	bus_index = AudioServer.get_bus_index(bus_name)
	
#	value_changed.connect(_on_value_change)
#	print(bus_index)
	
#	value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))

#func _on_value_change(value: float) -> void:
#	print(bus_index)
#	AudioServer.set_bus_volume_db(
#		bus_index,
#		linear_to_db(value)
#	)
