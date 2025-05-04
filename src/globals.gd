extends Node

@onready var player : Player = get_tree().root.get_node("World/SubViewportContainer/SubViewport/Player")
@onready var flame : Node3D = get_tree().root.get_node("World/SubViewportContainer/SubViewport/Flame")
