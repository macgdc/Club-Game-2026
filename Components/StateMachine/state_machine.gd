# followed https://www.youtube.com/watch?v=ow_Lum-Agbs&t=239s
extends Node
class_name StateMachine

@export var initial_state: State
@export var actor : Node

var current_state: State
var states: Dictionary[String, State] = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(on_change_state)
	
	if initial_state:
		#await get_tree().process_frame
		initial_state.enter(actor)
		current_state = initial_state


func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)


func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


func on_change_state(new_state_name: String, ) -> void:
	var new_state: State = states.get(new_state_name.to_lower())
	
	assert(new_state, "State not found: " + new_state_name)
	
	if current_state:
		current_state.exit()
	
	new_state.enter(actor)
	
	current_state = new_state
