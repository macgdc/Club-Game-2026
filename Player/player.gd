extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity : float = 0.25

# Not sure if this is the best way to handle stats but its whatever
@export var stats: Stats

@onready var _camera_pivot : Node3D = %CameraPivot
@onready var _camera : Camera3D = %Camera3D
@onready var _skin : SophiaSkin = %SophiaSkin

var _camera_input_direction : Vector2 = Vector2.ZERO
var _last_movement_direction : Vector3 = Vector3.BACK
var _gravity : float = -30.0


func _unhandled_input(event: InputEvent) -> void:
	# If mouse moved and cursor is invisible
	var is_camera_motion : bool = (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		_camera_input_direction = event.screen_relative * mouse_sensitivity


func _physics_process(delta: float) -> void:
	# Camera Vertical
	_camera_pivot.rotation.x += _camera_input_direction.y * delta
	_camera_pivot.rotation.x = clamp(_camera_pivot.rotation.x, -PI/6.0, PI/3.0)
	
	# Camera Horizontal
	_camera_pivot.rotation.y -= _camera_input_direction.x * delta
	
	_camera_input_direction = Vector2.ZERO # So it doesn't keep rotating
	
	# Gets Move Direction
	var raw_input : Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	# Basis is based on the orientation of the node
	var forward : Vector3 = _camera.global_basis.z
	var right : Vector3 = _camera.global_basis.x
	var move_direction : Vector3 = forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0 # Because camera may be looking down on player (we don't want to move player into ground)
	move_direction = move_direction.normalized()
	
	# Get Velocity
	var y_velocity : float = velocity.y
	velocity.y = 0.0 # Use gravity to calculate y not move_direction
	velocity = move_direction * stats.move_speed
	
	
	velocity.y = y_velocity + _gravity * delta
	var is_starting_jump : bool = Input.is_action_just_pressed("jump") and is_on_floor()
	if is_starting_jump:
		velocity.y += stats.jump_strength
	
	move_and_slide()
	
	
	# ========== Animation Stuff ===========
	if move_direction.length_squared() > 0.1:
		_last_movement_direction = move_direction
	# Vector3.BACK is the forward dir in game world
	var target_angle : float = Vector3.BACK.signed_angle_to(_last_movement_direction, Vector3.UP)
	_skin.global_rotation.y = lerp_angle(_skin.rotation.y, target_angle, stats.rotation_speed * delta)
	
	if is_starting_jump:
		_skin.jump()
	elif not is_on_floor() and velocity.y < 0: # in air and falling
		_skin.fall()
	elif is_on_floor():
		var ground_speed : float = velocity.length_squared()
		if ground_speed > 0.0:
			_skin.move()
		else:
			_skin.idle()
