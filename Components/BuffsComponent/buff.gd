extends Resource
class_name Buff

signal buff_changed(new_multiplier: float)

@export var multiplier: float = 1.0: set = _on_buff_changed

func _on_buff_changed(new_value: float) -> void:
	multiplier = new_value
	buff_changed.emit(multiplier)
