extends Control

signal start_pressed

var start_screen : Control

func _ready() -> void:
	show_start_screen()

# Move this to the GUI script
func show_start_screen():
	var start_screen_scene = preload("res://GUI/StartMenu/start_screen.tscn")
	start_screen = start_screen_scene.instantiate()
	add_child(start_screen)
	
	# Connecting signal
	start_screen.play_pressed.connect(_on_start_screen_play_pressed)


# Signal Connections
func _on_start_screen_play_pressed() -> void:
	# This is where we should load levels, we prob need to add a load screen aswell
	print("Loading world")
	start_pressed.emit()
	if start_screen:
		start_screen.queue_free()
		start_screen = null
