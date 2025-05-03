class_name Gun
extends Node3D

@export var bullet_scene : PackedScene

@onready var bullets : Node3D = %Bullets
@onready var camera : CameraShake = %Camera
@onready var muzzle_flash : MuzzleFlash = %MuzzleFlash
@onready var bullet_spawn : Node3D = %BulletSpawn

func shoot() -> void:
	var bullet : RigidBody3D = bullet_scene.instantiate()
	bullets.add_child(bullet)
	bullet.global_transform = bullet_spawn.global_transform
	bullet.apply_impulse(-bullet_spawn.global_transform.basis.z.normalized() * 50.0)
	
	# screenshake
	camera.shake(0.25, 0.01)
	
	muzzle_flash.start_flash()
