extends Resource
class_name HealthComponent

signal health_empty
signal health_changed(current_health: float, max_health: float)

@export var base_max_health: float = 100.0

var current_max_health: float
var health: float: set = _on_health_changed


func _ready() -> void:
	current_max_health = base_max_health
	health = current_max_health


func _on_health_changed(new_value: float) -> void:
	health = clampf(new_value, 0.0, current_max_health)
	health_changed.emit(health, current_max_health)
	if health <= 0:
		health_empty.emit()
