extends Node


var audio_stream_player : AudioStreamPlayer

@warning_ignore_start("unused_signal")

# Dialogue signals
signal choice1
signal choice2
signal choice_scene

# Combat signals
signal entered_battle
signal turn_changed
signal battle_lost
signal battle_won

@warning_ignore_restore("unused_signal")

var is_choice_being_made : bool = false # Self explanatory

# Battle state variables
var InBattle : bool = false
var turn : int = 0
var char_turn : Character
var dead_characters : int = 0

# Enemy battle resources 
var current_enemy1 : Resource
var current_enemy2 : Resource
var current_enemy3 : Resource
var current_enemy4 : Resource

# Player node, to get its stats and sprite
var current_char1 : Player
var current_char2 : Player
var current_char3 : Player
var current_char4 : Player


# Connect to "turn_changed" signal
func _ready() -> void :
	
	self.connect("turn_changed", _on_turn_changed)


# Called whenever a character or enemy finishes their action
func _on_turn_changed(cur_char : Sprite3D) -> void :
	
	# if every character is dead, a signal is emitted
	if dead_characters == 4 :
		
		emit_signal("you_lost")
	
	turn += 1 # Go to next turn
	
	cur_char.your_turn = false 
	
	# If the current node is a character, the action panel is shown
	if cur_char.class_name_ == "Character" :
		
		cur_char.battle_hud.get_child(1).visible = false
	
	# if the current node is the last, turn is reset to 0
	else :
		
		if cur_char.get_index() == (cur_char.get_parent().get_child_count() - 1) :
			
			turn = 0


# Called after getting out of combat, to reset the enemies
func reset_enemies() -> void :
	
	current_enemy1 = null
	current_enemy2 = null
	current_enemy3 = null
	current_enemy4 = null
