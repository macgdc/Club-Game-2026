extends Resource
class_name Stats

# Base values
@export var base_move_speed: float = 10.0
@export var base_rotation_speed: float = 10.0
@export var base_jump_strength: float = 10.0
@export var base_defense: float = 10.0

# Buffs in percentages
# Ex 50% attack buff is 
var speed_buffs: float = 0
var attack_buffs: float = 0
var defense_buffs: float = 0

# I think I should scrap all this!!!
# I think having the movement part of the player script is fine
# Make another component called stats which is the deadcells stats
