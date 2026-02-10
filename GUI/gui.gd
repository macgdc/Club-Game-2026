extends CanvasLayer

signal start_pressed
signal pause_game
signal unpause_game
signal quit_run

@onready var start_screen : Control = null
@onready var pause_menu : Control = null


func _ready() -> void:
	_show_start_screen()


func _input(event : InputEvent) -> void:
	# ui_cancel = Escape key
	if event.is_action_pressed("ui_cancel"):
		if pause_menu:
			if pause_menu.is_visible_in_tree():
				_hide_pause_menu()
			else:
				_unhide_pause_menu()


func _show_start_screen():
	var start_screen_scene = preload("res://GUI/StartMenu/start_screen.tscn")
	start_screen = start_screen_scene.instantiate()
	add_child(start_screen)
	
	# Connecting signal
	start_screen.play_pressed.connect(_on_start_screen_play_pressed)


func _create_pause_menu() -> void:
	var pause_menu_scene = preload("res://GUI/PauseMenu/pause_menu.tscn")
	pause_menu = pause_menu_scene.instantiate()
	add_child(pause_menu)
	_hide_pause_menu()
	
	# Connecting signals
	pause_menu.back_pressed.connect(_hide_pause_menu)
	pause_menu.quit_pressed.connect(_quit_run)


func _hide_pause_menu() -> void:
	if pause_menu:
		unpause_game.emit()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		pause_menu.visible = false


func _unhide_pause_menu() -> void:
	if pause_menu:
		pause_game.emit()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		pause_menu.visible = true


# Should delete game GUI's (maybe do saving here aswell or game manager
func _quit_run() -> void:
	quit_run.emit()
	if pause_menu:
		pause_menu.queue_free()
		pause_menu = null
	# Remove other GUIS like overlays
	_show_start_screen()


# Signal Connections
func _on_start_screen_play_pressed() -> void:
	# This is where we should load levels, we prob need to add a load screen aswell
	print("Loading world")
	start_pressed.emit()
	_create_pause_menu()
	if start_screen:
		start_screen.queue_free()
		start_screen = null
