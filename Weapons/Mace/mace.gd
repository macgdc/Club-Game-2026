extends WeaponComponent

@onready var mace_skin = %"Mace Skin"

func _ready() -> void:
	setup() # From Weapon Component


# Could also be based on the weapon anim player instead
func _on_player_animator_animation_finished(_anim_name: String):
	mace_skin.visible = false
