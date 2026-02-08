extends Node

var game_manager : GameManager

# Some universal helper methods which may come in handy

# For pausing a subtree of nodes
# NOTE: that this will not stop _gui_input() for buttons and such.
# That can be done with something like root.propagate_call("set",
# ["mouse_filter", Control.MOUSE_FILTER_IGNORE])
func SetPauseSubtree(root: Node, pause: bool) -> void:
	var process_setters = ["set_process",
	"set_physics_process",
	"set_process_input",
	"set_process_unhandled_input",
	"set_process_unhandled_key_input",
	"set_process_shortcut_input",]
	
	for setter in process_setters:
		root.propagate_call(setter, [!pause])
		
	for child in root.get_children():
		if child is AnimationPlayer:
			if pause:
				child.pause()
			else:
				child.play()  # or resume, depending on your setup
		SetPauseSubtree(child, pause)
