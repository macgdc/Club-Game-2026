extends Node3D

#signal attack1_finish
#signal attack2_finish

@onready var anim_player = %AnimationPlayer
const attack1_anim_name: String = "mace_anims/Mace Attack"
const attack2_anim_name: String = "mace_anims/Mace Attack 2"

func attack1() -> void:
	anim_player.play(attack1_anim_name)

# maybe add some blend time
func attack2() -> void:
	anim_player.play(attack2_anim_name)


#func _on_animation_player_animation_finished(anim_name: String):
	#if anim_name == attack1_anim_name:
		#attack1_finish.emit()
	#else:
		#attack2_finish.emit()
