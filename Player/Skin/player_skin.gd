extends Node3D

@onready var anim_tree = %AnimationTree

# I don't think i should use a state machine, just player
var state_machine: AnimationNodeStateMachinePlayback

func _ready() -> void:
	state_machine = anim_tree.get("parameters/playback")
	state_machine.start("idle")


func idle() -> void:
	state_machine.travel("idle")


func move() -> void:
	state_machine.travel("move")


func jump() -> void:
	state_machine.travel("jump")


func fall() -> void:
	state_machine.travel("jump")
