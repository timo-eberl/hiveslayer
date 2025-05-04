extends Node

@onready var player : Player = get_tree().root.get_node("World/SubViewportContainer/SubViewport/Player")
@onready var flame : Node3D = get_tree().root.get_node("World/SubViewportContainer/SubViewport/Flame")
@onready var enemy_spawner : EnemySpawner = get_tree().root.get_node("World/SubViewportContainer/SubViewport/EnemySpawner")
@onready var control : Control = get_tree().root.get_node("World/Control")
