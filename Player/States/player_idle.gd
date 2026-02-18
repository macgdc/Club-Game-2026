extends State
class_name PlayerIdle

var player : CharacterBody3D

func enter(actor: Node) -> void:
	assert(actor is CharacterBody3D, "Player Idle state cannot initialize since actor is not CharacterBody3D it is: " + str(actor))
	player = actor as CharacterBody3D


func physics_update(delta: float) -> void:
	# Gravity
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if player.move_direction == Vector3.ZERO and player.is_on_floor():
		player.skin.idle()
	else:
		state_transition.emit("move")
