extends Node3D

@export var bullet_scene : PackedScene

@onready var bullets : Node3D = %Bullets
@onready var camera : CameraShake = %Camera
@onready var muzzle_flash : MuzzleFlash = %MuzzleFlash

func _physics_process(_delta: float) -> void:
	if Input.is_action_just_pressed("shoot"):
		var bullet : RigidBody3D = bullet_scene.instantiate()
		bullets.add_child(bullet)
		bullet.global_transform = self.global_transform
		bullet.apply_impulse(-self.global_transform.basis.z * 300.0)
		
		# screenshake
		camera.shake(0.25, 0.01)
		
		muzzle_flash.start_flash()
