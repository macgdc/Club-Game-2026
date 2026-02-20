extends Node3D

@onready var anim_tree = %AnimationTree

var state_machine: AnimationNodeStateMachinePlayback

func _ready() -> void:
	state_machine = anim_tree.get("parameters/playback")
	state_machine.start("idle")


func idle() -> void:
	state_machine.travel("idle")


func move() -> void:
	state_machine.travel("move")
