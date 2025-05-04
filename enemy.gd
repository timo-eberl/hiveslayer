class_name Enemy
extends CharacterBody3D

@export var movement_speed: float = 2.0

@onready var nav_agent : NavigationAgent3D = $NavigationAgent3D

func _ready():
	# Make sure to not await during _ready.
	actor_setup.call_deferred()

func actor_setup():
	# Wait for the first physics frame so the NavigationServer can sync.
	await get_tree().physics_frame

	# Now that the navigation map is no longer empty, set the movement target.
	nav_agent.set_target_position(%Flame.global_position)

func _physics_process(delta):
	if nav_agent.is_navigation_finished():
		return

	var current_agent_position: Vector3 = global_position
	var next_path_position: Vector3 = nav_agent.get_next_path_position()

	velocity = current_agent_position.direction_to(next_path_position) * movement_speed
	
	var z := -velocity.normalized()
	var y := Vector3.UP
	var x := -z.cross(y).normalized()
	y = -x.cross(z).normalized()
	var target_rotation := Basis(x,y,z).get_rotation_quaternion()
	self.quaternion = self.quaternion.slerp(target_rotation, delta * 5.0)
	
	move_and_slide()
