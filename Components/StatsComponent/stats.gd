extends Node3D
class_name Stats
# Dead Cells specific stats https://deadcells.wiki.gg/wiki/Stats
# These effect both damage and health
# Adding the health changes directly, damage changes are going
# to be done through the signal to talk to the weapon

# TODO: I think separating the stats part into
# its own class and calling this like StatsComponent
# would be nice where the component just contains
# a Stats variable + the connection to the Health
# Component
# RIGHT NOW ITS NOT NECESSARY and it may just be over
# engineering

signal brutality_changed(new_level: int)
signal tactics_changed(new_level: int)
signal survival_changed(new_level: int)

# Stats
@export var brutality_level: int = 1: set = _on_brutality_changed
@export var tactics_level: int = 1: set = _on_tactics_changed
@export var survival_level: int = 1: set = _on_survival_changed

@export var health_component: HealthComponent


func update_health() -> void:
	var multiplier: float = get_brutality_health_multiplier() * get_tactics_health_multiplier() * get_survival_health_multiplier()
	var old_health_max = health_component.current_max_health
	health_component.current_max_health = health_component.base_max_health * multiplier
	health_component.health += health_component.current_max_health - old_health_max
	print("New Max Health: ", health_component.current_max_health)


func get_brutality_health_multiplier() -> float:
	if brutality_level == 1:
		return 1
	elif brutality_level == 2:
		return 1.65
	elif brutality_level <= 34:
		var s: float = brutality_level - 1
		return 1 + (897.0/1360.0)*s - (13.0/1360.0)*s*s
	else:
		return 12.375


func get_tactics_health_multiplier() -> float:
	if tactics_level == 1:
		return 1
	elif tactics_level == 2:
		return 1.5
	elif tactics_level <= 24:
		var s: float = tactics_level - 1
		return 1 + (49.0/96.0)*s - (1.0/96.0)*s*s
	else:
		return 7.25


func get_survival_health_multiplier() -> float:
	if survival_level == 1:
		return 1
	if survival_level == 2:
		return 1.7
	elif survival_level <= 59:
		var s: float = survival_level - 1
		return 1 + (833.0/1180.0) * s - (7.0/1180.0)*s*s
	else:
		return 22


func _on_brutality_changed(new_value: int) -> void:
	brutality_level = new_value
	update_health.call_deferred()
	brutality_changed.emit(brutality_level)


func _on_tactics_changed(new_value: int) -> void:
	tactics_level = new_value
	update_health.call_deferred()
	tactics_changed.emit(tactics_level)


func _on_survival_changed(new_value: int) -> void:
	survival_level = new_value
	update_health.call_deferred()
	survival_changed.emit(survival_level)
