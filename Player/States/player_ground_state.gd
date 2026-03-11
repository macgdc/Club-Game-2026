extends State
class_name PlayerGroundState

var player : Player

func enter(actor: Node) -> void:
	assert(actor is Player, "Player Ground State cannot initialize since actor is not Player type it is: " + str(actor))
	player = actor as Player
	player.jump_count = 0


func physics_update(delta: float) -> void:
	# Probably be moved to air state enter()
	if player.is_on_floor() == false:
		if player.velocity.y > 0.0:
			player.skin.jump()
		else:
			player.skin.fall()
		player.move_and_slide()
		state_transition.emit("air")
		return
		
	if Input.is_action_just_pressed("jump"):
		player.velocity.y = player.jump_strength
		player.skin.jump()
		player.move_and_slide()
		#state_transition.emit("jump1")
		return
	
	if Input.is_action_just_pressed("left_click"):
		state_transition.emit("primary")
		return

	player.move_and_slide()
	
	#var is_moving: bool = player.move_direction != Vector3.ZERO
	#if is_moving:
		#player.last_move_direction = player.move_direction
	
	player.rotate_skin(delta)
	
	if player.is_moving():
		player.skin.move()
	else:
		player.skin.idle()
