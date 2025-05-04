class_name EnemySpawner
extends Node3D

@export var enemy_scene : PackedScene

@export var distance_min := 200
@export var distance_max := 220

var rng = RandomNumberGenerator.new()

func spawn_group():
	var angle := rng.randf_range(0, TAU)
	var unit_circle_pos := Vector2(cos(angle), sin(angle))
	print("unit_circle_pos: ", unit_circle_pos)
	var distance := rng.randf_range(distance_min, distance_max)
	var pos2d := unit_circle_pos * distance
	var group_pos := Vector3(pos2d.x, 0, pos2d.y) + self.global_position
	
	var group_size := 4
	for i in range(group_size):
		var d := 1.5
		spawn_enemy(group_pos + Vector3(rng.randf_range(-d, d), 0, rng.randf_range(-d, d)))

func spawn_enemy(pos : Vector3):
	var enemy : Node3D = enemy_scene.instantiate()
	self.add_child(enemy)
	enemy.global_position = pos

func _ready() -> void:
	while true:
		spawn_group()
		spawn_group()
		await get_tree().create_timer(10).timeout
