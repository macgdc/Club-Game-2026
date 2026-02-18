extends State
class_name PlayerMove

var player: CharacterBody3D
var is_starting_jump: bool = false

func enter(actor: Node) -> void:
	assert(actor is CharacterBody3D, "Player Idle state cannot initialize since actor is not CharacterBody3D it is: " + str(actor))
	player = actor as CharacterBody3D


func physics_update(delta: float) -> void:
	if player.move_direction == Vector3.ZERO:
		# Gravity
		player.velocity.y += player.gravity * delta
		player.velocity.x = 0
		player.velocity.z = 0
		state_transition.emit("idle")
	else:
		# Set Velocity
		var y_velocity : float = player.velocity.y
		player.velocity.y = 0.0 # Use gravity to calculate y not move_direction
		player.velocity = player.move_direction * player.move_speed
		player.velocity.y = y_velocity + player.gravity * delta
		
	player.move_and_slide()
	
	# Animations
	if player.move_direction.length_squared() > 0.1:
		player.last_move_direction = player.move_direction
	# Vector3.BACK is the forward dir in game world
	var target_angle : float = Vector3.BACK.signed_angle_to(player.last_move_direction, Vector3.UP)
	player.skin.global_rotation.y = lerp_angle(player.skin.rotation.y, target_angle, player.rotation_speed * delta)
	
	
	if player.is_on_floor():
		player.skin.move()
		#var ground_speed : float = velocity.length_squared()
		#if ground_speed > 0.0:
			#skin.move()
		#else:
			#skin.idle()
