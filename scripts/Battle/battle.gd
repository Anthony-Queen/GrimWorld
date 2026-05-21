extends Node3D


@warning_ignore_start("unused_signal")

# Combat signals
signal turn_changed
signal battle_lost
signal battle_won

@warning_ignore_restore("unused_signal")

# Battle state variables
var in_battle : bool = false
var char_attacking : Character
var dead_characters : int = 0

@export var characters_node : Node3D
@export var enemies_node : Node3D


# Connect to "turn_changed" signal
func _ready() -> void :
	
	get_parent().battle = self
	self.connect("turn_changed", _on_turn_changed)
	self.connect("battle_won", get_parent()._on_battle_won)


# Called whenever a character or enemy finishes their action
func _on_turn_changed(cur_char : Sprite3D) -> void :
	
	# if every character is dead, a signal is emitted
	if dead_characters == 4 :
		
		emit_signal("you_lost")
	
	cur_char.your_turn = false 
	
	# If the current node is a character, the action panel is hidden
	if cur_char.class_name_ == "Character" :
		
		await cur_char.battle_hud.get_child(1).fade_out_right_left()
	
	# if the current node is the last, turn is reset to 0
	else :
		
		cur_char.attacked = false
	
	calc_speed_and_turns()


func calc_speed_and_turns() -> void :
	
	var dictionary : Dictionary
	
	for i in characters_node.get_children():
		
		if i.played == false :
			
			dictionary["Characters/" + str(i.name)] = i.speed
		
	for i in enemies_node.get_children():
		
		if i.played == false :
			
			dictionary["Enemies/" + str(i.name)] = i.speed
	
	dictionary.sort()
	
	dictionary = sort_dictionary_by_value(dictionary)
	
	var dictionary_keys : Array = dictionary.keys()
	
	get_node(dictionary_keys[-1]).your_turn = true


func sort_dictionary_by_value(dictionary : Dictionary) :
	
	var dictionary_keys = dictionary.keys()
	var dictionary_values = dictionary.values()
	
	dictionary_values.sort()
	
	var sorted_dictionary : Dictionary
	
	for i in dictionary_keys.size() :
		
		sorted_dictionary.set(dictionary.find_key(dictionary_values[i]), dictionary_values[i])
		dictionary.erase(dictionary.find_key(dictionary_values[i]))
	
	return sorted_dictionary
