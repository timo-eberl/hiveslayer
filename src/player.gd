class_name Player
extends CharacterBody3D

# First person camera controller

@export var look_speed := 0.25
@export var rotation_limit_upwards := 90
@export var rotation_limit_downwards := 90
@export var walking_speed := 5.0
@export var running_speed := 10.0
@export var jump_velocity := 5.0

var enabled := false
#Checks how sensitive the mouse is
var mouse_sensitivity := 0.000002


@onready var camera : Node3D = %CameraParent
@onready var gun : Gun = %Gun
@onready var initial_position : Vector3 = self.global_position
@onready var menu = %Control

	
# look with mouse
func _unhandled_input(event: InputEvent) -> void:
	if !enabled:
		return
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		event.relative *= mouse_sensitivity
		if OS.has_feature("web"):
			event.relative *= 5.0
		self.rotation_degrees.y -= look_speed * event.relative.x;
		camera.rotation_degrees.x -= look_speed * event.relative.y;
		camera.rotation_degrees.x = clampf(camera.rotation_degrees.x, -rotation_limit_upwards, rotation_limit_downwards)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_cancel"):
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		menu.pause = false
	if Input.is_action_just_pressed("mouse_click") and menu.started:
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		menu.pause = true
	
	if !enabled:
		return
	var input_dir := Input.get_vector("look_left", "look_right", "look_up", "look_down")
	self.rotation_degrees.y -= look_speed * input_dir.x * delta * 500.0;
	camera.rotation_degrees.x -= look_speed * input_dir.y * delta * 500.0;
	camera.rotation_degrees.x = clampf(camera.rotation_degrees.x, -rotation_limit_upwards, rotation_limit_downwards)

func _physics_process(delta: float) -> void:
	if !enabled:
		return
	# Add the gravity.
	if not is_on_floor():
		self.velocity += get_gravity() * delta
	else:
		self.velocity += get_gravity() * 10.0 * delta # stick to the ground when not jumping

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		self.velocity.y = jump_velocity

	# Handle shooting
	if Input.is_action_just_pressed("shoot"):
		gun.shoot()

	# Get the input direction and handle the movement/deceleration.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	var speed = running_speed if Input.is_action_pressed("running") else walking_speed
	if direction:
		self.velocity.x = direction.x * speed
		self.velocity.z = direction.z * speed
	else:
		self.velocity.x = move_toward(self.velocity.x, 0, speed)
		self.velocity.z = move_toward(self.velocity.z, 0, speed)

	self.move_and_slide()
	
	# respawn when falling down
	if self.global_position.y < -3.0:
		self.global_position = initial_position
