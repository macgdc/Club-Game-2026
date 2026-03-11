extends Node3D
class_name WeaponComponent
## This should be extended

@export var weapon: Weapon
#@export var model: Node3D
#@export var anims_fsm: AnimationNodeStateMachine
@export var state_machine: StateMachine
@export var weapon_states: Array[WeaponState]
@export var init_state: WeaponState
@export var is_primary: bool

# This will add the weapon states to the player state machine
func setup() -> void:
	for state in weapon_states:
		if state == init_state:
			if is_primary:
				state_machine.states["primary"] = state
				state.input_action = "left_click"
			else:
				state_machine.states["secondary"] = state
				state.input_action = "right_click"
		else:
			state_machine.states[state.name.to_lower()] = state
			if is_primary:
				state.input_action = "left_click"
			else:
				state.input_action = "right_click"
		
		state.state_transition.connect(state_machine.on_change_state)
		state.weapon = weapon
