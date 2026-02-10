extends Control

signal back_pressed
signal quit_pressed

func _on_back_pressed() -> void:
	back_pressed.emit()


func _on_options_pressed() -> void:
	pass # Replace with function body.


func _on_restart_pressed() -> void:
	pass # Replace with function body.


func _on_quit_pressed() -> void:
	quit_pressed.emit()
