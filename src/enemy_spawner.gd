class_name EnemySpawner
extends Node3D

@export var enemy_scene : PackedScene

@export var distance_min := 200
@export var distance_max := 220

var rng = RandomNumberGenerator.new()

func spawn_group():
	var angle := rng.randf_range(0, TAU)
	var unit_circle_pos := Vector2(cos(angle), sin(angle))
	var distance := rng.randf_range(distance_min, distance_max)
	var pos := unit_circle_pos * distance
	spawn_enemy(Vector3(pos.x, 0, pos.y))

func spawn_enemy(pos : Vector3):
	var enemy : Node3D = enemy_scene.instantiate()
	self.add_child(enemy)
	enemy.global_position = pos

func _ready() -> void:
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
	spawn_group()
