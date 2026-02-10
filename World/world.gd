extends Node3D

var player : CharacterBody3D
var current_map : Node3D # Should be our own Map type

# TODO: Make this create a player based on a save file
func create_player() -> void:
	var player_scene = preload("res://Player/player.tscn")
	player = player_scene.instantiate()
	add_child(player)


# This should load the map player is currently on in their save
func load_map() -> void:
	var map_scene = preload("res://World/Maps/TestMap/test_map.tscn")
	current_map = map_scene.instantiate()
	add_child(current_map)


func pause() -> void:
	Global.SetPauseSubtree(self, true)


func unpause() -> void:
	Global.SetPauseSubtree(self, false)


func save_and_quit() -> void:
	# TODO: Add saving logic here
	print("Saving...")
	for child in get_children():
		child.queue_free()
