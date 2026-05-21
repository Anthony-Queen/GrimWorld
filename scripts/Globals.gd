extends Node


var audio_stream_player : AudioStreamPlayer

@warning_ignore_start("unused_signal")

# Dialogue signals
signal choice1
signal choice2
signal choice_scene

# Emitted when entering battle
signal entered_battle

@warning_ignore_restore("unused_signal")

var is_choice_being_made : bool = false # Self explanatory

# Enemy battle resources 
var current_enemy1 : Resource
var current_enemy2 : Resource
var current_enemy3 : Resource
var current_enemy4 : Resource


# Called after getting out of combat, to reset the enemies
func reset_enemies() -> void :
	
	current_enemy1 = null
	current_enemy2 = null
	current_enemy3 = null
	current_enemy4 = null
