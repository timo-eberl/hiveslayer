class_name Gun
extends Node3D

@export var bullet_scene : PackedScene

@onready var bullets : Node3D = %Bullets
@onready var camera : CameraShake = %Camera
@onready var muzzle_flash : MuzzleFlash = %MuzzleFlash
@onready var bullet_spawn : Node3D = %BulletSpawn
@onready var animation_player : AnimationPlayer = $AnimationPlayer

var grenade = preload("res://grenade.tscn")

func shoot() -> void:
	var bullet : RigidBody3D = bullet_scene.instantiate()
	bullets.add_child(bullet)
	bullet.global_transform = bullet_spawn.global_transform
	bullet.apply_impulse(-bullet_spawn.global_transform.basis.z.normalized() * 50.0)
	
	# screenshake
	camera.shake(0.25, 0.01)
	
	muzzle_flash.start_flash()
	
	animation_player.stop()
	animation_player.play("recoil")
	
func throw():
		var grenadeins = grenade.instantiate()
		grenadeins.global_position = bullet_spawn.global_position
		get_tree().current_scene.add_child(grenadeins)
		
		
		var force = -18
		var up_direction = 3.5
		
		var player_rotation = camera.global_transform.basis.z.normalized()
		
		grenadeins.apply_central_impulse(player_rotation * force + Vector3(0, up_direction, 0))
	
	
	
