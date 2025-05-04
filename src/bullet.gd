extends RigidBody3D

@export var ground_particles_scene : PackedScene

func _on_body_entered(body: Node) -> void:
	queue_free()
	if body is StaticBody3D:
		# we (probably) hit the ground
		# spawn dirt particles
		var particles : Node3D = ground_particles_scene.instantiate()
		self.add_sibling(particles)
		particles.global_position = self.global_position
		for c in particles.get_children():
			if c is GPUParticles3D:
				c.emitting = true
	
	if body is Enemy:
		body.take_damage(25)
