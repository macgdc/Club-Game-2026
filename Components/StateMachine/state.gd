extends Node
class_name State

signal state_transition

# state_name is whatever the node name is
#var state_name: String:
	#get:
		#return name

func enter(_actor: Node) -> void:
	pass


func exit() -> void:
	pass


func update(_delta: float) -> void:
	pass


func physics_update(_delta: float) -> void:
	pass
