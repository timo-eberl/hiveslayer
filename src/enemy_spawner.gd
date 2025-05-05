class_name EnemySpawner
extends Node3D

@export var possible_enemies : Array[PackedScene]
@export var enemy_scene : PackedScene

@export var distance_min := 200
@export var distance_max := 220

@onready var gameStarted = %Control

var rng = RandomNumberGenerator.new()

func spawn_group():
	var angle := rng.randf_range(0, TAU)
	var unit_circle_pos := Vector2(cos(angle), sin(angle))
	var distance := rng.randf_range(distance_min, distance_max)
	var pos2d := unit_circle_pos * distance
	var group_pos := Vector3(pos2d.x, 0, pos2d.y) + self.global_position
	
	var group_size := 6
	for i in range(group_size):
		var d := 2.5
		spawn_enemy(group_pos + Vector3(rng.randf_range(-d, d), 0, rng.randf_range(-d, d)))

func spawn_enemy(pos : Vector3):
	randomize() # Randomizes the seed (or the internal state) of the random number generator
	var enemy : Enemy = possible_enemies[randi() % possible_enemies.size()].instantiate()
	
	self.add_child(enemy)
	enemy.global_position = pos

func _start() -> void:
	while true:
		spawn_group()
		await get_tree().create_timer(8).timeout

func kill_them_all():
	for child in self.get_children():
		if child is Enemy:
			child.take_damage(1000, child.global_position)

func _on_button_pressed() -> void:
	_start() # Replace with function body.
