extends State
class_name PlayerAirState

var player : Player

func enter(actor: Node) -> void:
	assert(actor is Player, "Player Air State cannot initialize since actor is not Player type it is: " + str(actor))
	player = actor as Player
	player.jump_count = 1


func physics_update(delta: float) -> void:
	var is_moving: bool = player.move_direction != Vector3.ZERO
	
	# This should prob be moved to enter() in ground state
	if player.is_on_floor():
		if is_moving:
			player.skin.move()
		else:
			player.skin.idle()
		player.move_and_slide()
		state_transition.emit("ground")
		return
		
	if Input.is_action_just_pressed("jump") and player.can_jump():
		player.jump_count += 1
		player.velocity.y = player.jump_strength
		player.skin.jump()
		player.move_and_slide()
		#state_transition.emit("jump2")
		return

	player.move_and_slide()
	
	
	if is_moving:
		player.last_move_direction = player.move_direction
	
	player.rotate_skin(delta)
	
	if player.velocity.y > 0:
		player.skin.jump()
	else:
		player.skin.fall()
