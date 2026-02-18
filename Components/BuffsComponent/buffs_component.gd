extends Node
class_name BuffsComponent

@export var dict: Dictionary[String, Buff]

func get_buff(buff_name: String) -> Buff:
	assert(dict.has(buff_name), "The buff '" + buff_name + "' does not exist.")
	return dict[buff_name]


func get_multiplier(buff_name: String) -> float:
	assert(dict.has(buff_name), "The buff '" + buff_name + "' does not exist.")
	return dict[buff_name].multiplier


func set_multiplier(buff_name: String, value: float) -> void:
	assert(dict.has(buff_name), "The buff '" + buff_name + "' does not exist.")
	dict[buff_name].multiplier = value
