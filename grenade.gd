extends RigidBody3D
@export var explosionSound: AudioStreamWAV
var damage = 50
var explosion = preload("res://explosion.tscn")

func _on_body_entered(body):
	linear_damp = 0.3
	angular_damp = 1.5
	


func _on_fuse_timer_timeout() -> void:
	var explosion_instance = explosion.instantiate()
	get_tree().root.add_child(explosion_instance)
	explosion_instance.global_position = global_position
	SoundEffect3D.SoundPlayPosition(get_tree().root, global_position, explosionSound, randf_range(0.9, 1.1), 30)
	explosion_instance.get_node("GrenadeExplosion").emitting = true
	explosion_instance.get_node("BigSparks").emitting = true
	explosion_instance.get_node("Flash").emitting = true
	var bodies = $"BlastRadius".get_overlapping_bodies()
	for obj in bodies:
		if obj is Enemy:
			#This is the function where the enemy recieves damage.
			#Maybe different but for now it's enemy hit
			obj.take_damage(damage, self.global_position)
			
	queue_free()
