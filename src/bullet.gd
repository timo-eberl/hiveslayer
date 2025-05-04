extends RigidBody3D


func _on_body_entered(body: Node) -> void:
	queue_free()
	if body is StaticBody3D:
		print("ground hit")
	if body is Enemy:
		print("enemy hit")
