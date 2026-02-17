extends Node3D
# These buffs are multipliers applied to the base value
# Ex. 50% dmg buff = 1.5x

signal speed_changed(new_buff: float)
signal attack_changed(new_buff: float)
signal defense_changed(new_buff: float)

@export var speed: float = 1.0 : set = _on_speed_changed
@export var attack: float = 1.0 : set = _on_attack_changed
@export var defense: float = 1.0 : set = _on_defense_changed

func _on_speed_changed(new_value: float) -> void:
	speed = new_value
	speed_changed.emit(speed)


func _on_attack_changed(new_value: float) -> void:
	attack = new_value
	attack_changed.emit(attack)


func _on_defense_changed(new_value: float) -> void:
	defense = new_value
	defense_changed.emit(defense)
