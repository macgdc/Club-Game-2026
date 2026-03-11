extends WeaponState
#class_name MaceAttack2State

@export var attack_buffer_timer: Timer

@onready var mace_skin = %"Mace Skin"
@onready var player_animator: AnimationPlayer = %PlayerAnimator

var player : Player
var move_speed: float = 5.0
var is_attack_buffered: bool

func enter(actor: Node) -> void:
	#print("Entering Attack 2")
	assert(actor is Player, "Mace Attack 2 cannot initialize since actor is not Player type it is: " + str(actor))
	player = actor as Player
	player_animator.root_node = player.skin.get_path()
	is_attack_buffered = false
	attack()


func physics_update(delta: float) -> void:
	if Global.get_remaining_anim_time(mace_skin.anim_player) <= attack_buffer_timer.wait_time / 2 and mace_skin.anim_player.is_playing():
		attack_buffer_timer.start()

	if Input.is_action_just_pressed(input_action) and not attack_buffer_timer.is_stopped():
		is_attack_buffered = true
		state_transition.emit("primary")
	
	var vel_y: float = player.velocity.y
	
	# Reducing the movement speed during attack
	player.velocity = player.velocity.normalized()
	player.velocity *= move_speed
	player.velocity.y = vel_y
	player.move_and_slide()
	#player.rotate_skin(delta)
	#mace_skin.global_rotation.y = player.skin.global_rotation.y
	


func attack() -> void:
	mace_skin.visible = true
	mace_skin.attack2()
	player_animator.play("player_anims/Mace Attack 2")
	#print("ATTACKING 2!!!!")


func _on_attack_buffer_timeout():
	if not is_attack_buffered:
		if player.is_on_floor():
			state_transition.emit("ground")
		else:
			state_transition.emit("air")
