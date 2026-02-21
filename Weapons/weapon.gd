extends Resource
class_name Weapon

enum StatType {
	BRUTALITY,
	TACTICS,
	SURVIVAL
}

@export var weapon_name: String = "Sword"
@export var damage: float = 15.0
@export var weapon_model: PackedScene
@export var stat_type: StatType = StatType.BRUTALITY
