# The Game Manager bridge between the world and UI
class_name GameManager extends Node

@onready var world : Node3D = $World
@onready var gui : CanvasLayer = $GUI

func _ready() -> void:
	# Connect signals here
	gui.start_pressed.connect(_on_start_pressed)
	gui.pause_game.connect(_on_pause_game)
	gui.unpause_game.connect(_on_unpause_game)
	gui.quit_run.connect(_on_quit_run)


# Signal Connections
func _on_start_pressed() -> void:
	# Call world functions here
	world.create_player()
	world.load_map()


func _on_pause_game() -> void:
	world.pause()


func _on_unpause_game() -> void:
	world.unpause()


func _on_quit_run() -> void:
	world.save_and_quit()
