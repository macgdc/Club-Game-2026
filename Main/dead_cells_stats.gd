extends Node3D
class_name DeadStats
# Dead Cells specific stats https://deadcells.wiki.gg/wiki/Stats
# These effect both damage and health
# Adding the health changes directly, damage changes are going
# to be done through the signal to talk to the weapon

signal brutality_changed(new_level: int)
signal tactics_changed(new_level: int)
signal survival_changed(new_level: int)

# Stats
@export var brutality_level: int = 1: set = _on_brutality_changed
@export var tactics_level: int = 1: set = _on_tactics_changed
@export var survival_level: int = 1: set = _on_survival_changed

@export var health_component: HealthComponent

func update_health() -> void:
	var multiplier : float = get_brutality_health_multiplier() * get_tactics_health_multiplier() * get_survival_health_multiplier()
	var old_health_max = health_component.current_max_health
	health_component.current_max_health = health_component.base_max_health * multiplier
	health_component.health += health_component.current_max_health - old_health_max


func get_brutality_health_multiplier() -> float:
	if brutality_level <= 34:
		return 1 + (897.0/1360.0)*brutality_level - (13.0/1360.0)*brutality_level*brutality_level
	else:
		return 12.375
	
	#health_component.max_health = ceil(health_component.max_health * multiplier)
	#health_component.health = ceil(health_component.health * multiplier)


func get_tactics_health_multiplier() -> float:
	if tactics_level <= 24:
		return 1 + (49.0/96.0)*tactics_level - (1.0/96.0)*tactics_level*tactics_level
	else:
		return 7.25


func get_survival_health_multiplier() -> float:
	if survival_level <= 59:
		return 1 + (833.0/1180.0)* survival_level - (7.0/1180.0)*survival_level*survival_level
	else:
		return 22


func _on_brutality_changed(new_value: int) -> void:
	brutality_level = new_value
	brutality_changed.emit(brutality_level)


func _on_tactics_changed(new_value: int) -> void:
	tactics_level = new_value
	tactics_changed.emit(tactics_level)


func _on_survival_changed(new_value: int) -> void:
	survival_level = new_value
	survival_changed.emit(survival_level)
