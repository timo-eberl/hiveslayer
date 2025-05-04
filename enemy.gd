class_name Enemy
extends CharacterBody3D

@export var movement_speed: float = 2.0

@export var gore_scene : PackedScene
@export var splash_scene : PackedScene
@export var takeDamageSound : AudioStreamPlayer3D
@onready var center : Node3D = $Center

@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D

var rng = RandomNumberGenerator.new()
var _health := 3.0

func _ready():
	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	nav_agent.set_target_position(Globals.flame.global_position)

func take_damage(amount : float, hit_position : Vector3):
	_health -= amount
	takeDamageSound.pitch_scale = randf_range(0.9, 1.1) # Add random variation to sound pitch
	takeDamageSound.play()
	var outward_direction : Vector3 = (hit_position - center.global_position).normalized()
	
	for i in range(2):
		var rand_range := 0.25
		var splash : Node3D = splash_scene.instantiate()
		get_tree().root.add_child(splash)
		splash.global_position = center.global_position + Vector3(
			rng.randf_range(-rand_range, rand_range),
			rng.randf_range(0, rand_range),
			rng.randf_range(-rand_range, rand_range))
		
	
	# TODO hit effect
	if _health <= 0.0:
		queue_free()
		for i in range(25):
			var rand_range := 1.5
			var splatter_direction = Vector3(
				rng.randf_range(-rand_range, rand_range),
				rng.randf_range(-rand_range, rand_range),
				rng.randf_range(-rand_range, rand_range)
			) + Vector3(0,3,0)
			splatter_direction = splatter_direction.normalized()
			var gore : RigidBody3D = gore_scene.instantiate()
			get_tree().root.add_child(gore)
			gore.global_position = center.global_position
			gore.apply_impulse(splatter_direction * 30.0 * rng.randf_range(0.2, 1))
		# TODO die effect

func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = nav_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
	if velocity.length() > 0.0:
		var z := -velocity.normalized()
		var y := Vector3.UP
		var x := -z.cross(y).normalized()
		y = -x.cross(z).normalized()
		var target_rotation := Basis(x,y,z).get_rotation_quaternion()
		self.quaternion = self.quaternion.slerp(target_rotation, delta * 5.0)
	
	move_and_slide()
