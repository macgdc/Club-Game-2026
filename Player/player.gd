extends CharacterBody3D

@export_group("Camera")
@export_range(0.0, 1.0) var mouse_sensitivity : float = 0.25

@export_group("Movement")
@export var base_move_speed: float = 10.0
@export var base_rotation_speed: float = 10.0
@export var base_jump_strength: float = 10.0
@export var base_defense: float = 10.0
@export var gravity: float = -30.0

@onready var buffs : BuffsComponent = %BuffsComponent
@onready var camera_pivot : Node3D = %CameraPivot
@onready var camera : Camera3D = %Camera3D
@onready var skin : SophiaSkin = %SophiaSkin

# Current values
var move_speed: float
var rotation_speed: float
var jump_strength: float


var move_direction: Vector3 = Vector3.ZERO
var last_move_direction : Vector3 = Vector3.BACK
var camera_input_direction : Vector2 = Vector2.ZERO
var is_starting_jump: bool = false

func _ready() -> void:
	move_speed = base_move_speed * buffs.get_multiplier("speed")
	rotation_speed = base_rotation_speed
	jump_strength = base_jump_strength * buffs.get_multiplier("jump")
	buffs.get_buff("speed").buff_changed.connect(_on_speed_buff_changed)
	buffs.get_buff("jump").buff_changed.connect(_on_jump_buff_changed)


func _unhandled_input(event: InputEvent) -> void:
	# If mouse moved and cursor is invisible
	var is_camera_motion : bool = (
		event is InputEventMouseMotion and
		Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED
	)
	
	if is_camera_motion:
		camera_input_direction = event.screen_relative * mouse_sensitivity


func _physics_process(delta: float) -> void:
	# TODO: REMOVE THIS!!!!
	if Input.is_action_just_pressed("right_click"):
		buffs.set_multiplier("speed", 2.0)
		buffs.set_multiplier("jump", 2.0)
	
	# Camera Vertical
	camera_pivot.rotation.x += camera_input_direction.y * delta
	camera_pivot.rotation.x = clamp(camera_pivot.rotation.x, -PI/6.0, PI/3.0)
	
	# Camera Horizontal
	camera_pivot.rotation.y -= camera_input_direction.x * delta
	
	camera_input_direction = Vector2.ZERO # So it doesn't keep rotating
	
	# Gets Move Direction
	var raw_input : Vector2 = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	# Basis is based on the orientation of the node
	var forward : Vector3 = camera.global_basis.z
	var right : Vector3 = camera.global_basis.x
	move_direction = forward * raw_input.y + right * raw_input.x
	move_direction.y = 0.0 # Because camera may be looking down on player (we don't want to move player into ground)
	move_direction = move_direction.normalized()
	
	# Not putting this in the states since currently it would
	# be in all states
	# Jump + Animation
	is_starting_jump = Input.is_action_just_pressed("jump") and is_on_floor()
	if is_starting_jump:
		velocity.y += jump_strength
		skin.jump()
	elif not is_on_floor() and velocity.y < 0: # in air and falling
		skin.fall()
	
	# The state machine handles the rest!


func _on_speed_buff_changed(new_multiplier: float) -> void:
	move_speed = base_move_speed * new_multiplier


func _on_jump_buff_changed(new_multiplier: float) -> void:
	jump_strength = base_jump_strength * new_multiplier
