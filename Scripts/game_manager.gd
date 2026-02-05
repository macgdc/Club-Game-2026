# The Game Manager bridge between the world and UI
class_name GameManager extends Node

@onready var world_3d : Node3D = $World3D
@onready var gui : Control = $GUI

func _ready() -> void:
	show_start_screen()


func show_start_screen():
	var start_screen_scene = preload("res://Scenes/start_screen.tscn")
	var start_screen = start_screen_scene.instantiate()
	gui.add_child(start_screen)
	
	# Connecting signal
	start_screen.play_pressed.connect(_on_start_screen_play_pressed)


# Signal Connections
func _on_start_screen_play_pressed() -> void:
	# This is where we should load levels
	print("Loading world")
	# Remove the start screen
	var start_scene = gui.get_node("StartScreen") # I don't like this line but idk a better way lol
	if start_scene:
		start_scene.queue_free()
