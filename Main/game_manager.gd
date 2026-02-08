# The Game Manager bridge between the world and UI
class_name GameManager extends Node

@onready var world : Node3D = $World
@onready var gui : Control = $GUI

func _ready() -> void:
	# Connect signals here
	gui.start_pressed.connect(_on_start_pressed)


# Signal Connections
func _on_start_pressed() -> void:
	# Call world functions here
	world.create_player()
	world.load_map()
	
