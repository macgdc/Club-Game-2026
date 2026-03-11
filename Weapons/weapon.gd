extends Resource
class_name Weapon

enum StatType {
	BRUTALITY,
	TACTICS,
	SURVIVAL
}

@export var name: String = "Sword"
@export var damage: float = 15.0
@export var stat_type: StatType = StatType.BRUTALITY
