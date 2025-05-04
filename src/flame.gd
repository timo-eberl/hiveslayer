class_name Flame
extends Node3D

@export var max_health := 10.0
@export var regen_rate := 0.1

@onready var beam_mesh : MeshInstance3D = $MeshInstance3D
@onready var beam_mesh_initial_scale : Vector3 = beam_mesh.scale

@onready var health : float = max_health

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body is Enemy:
		body.take_damage(1000, body.global_position)
		self.take_damage()

func take_damage():
	health -= 1.0

func _process(delta: float) -> void:
	health += regen_rate * delta
	health = min(max_health, health)
	
	beam_mesh.scale = beam_mesh_initial_scale * max(0, health/max_health)
	
	if health <= 0.0:
		Globals.enemy_spawner.kill_them_all()
		Globals.enemy_spawner.queue_free()
		var t: Timer = Globals.control.timer
		t.stop()
		Globals.control.get_node("CanvasGameOver").visible = true
		queue_free()
