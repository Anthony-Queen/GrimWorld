extends PanelContainer


@export var offset : Vector2
@export var camera_3d : Camera3D


# Change position to current turn's character
func _on_visibility_changed() -> void :
	
	disable_buttons(false)
	
	self.position = camera_3d.unproject_position(Globals.char_turn.position) + offset


# Attack button
func _on_attack_button_up() -> void :
	
	Globals.char_turn.attacking = true
	
	Globals.char_turn.choose_enemy()
	
	disable_buttons(true)


# Cast spell button
func _on_spell_button_up() -> void :
	
	Globals.char_turn.choose_enemy()
	
	disable_buttons(true)


# Defend button
func _on_defend_button_up() -> void :
	
	Globals.char_turn.defend()
	
	disable_buttons(true)


# Use item button
func _on_item_button_up() -> void :
	
	Globals.char_turn.choose_enemy()
	
	disable_buttons(true)


# Spare enemy button
func _on_spare_button_up() -> void :
	
	Globals.char_turn.choose_enemy()
	
	disable_buttons(true)


# Run away button
func _on_run_button_up() -> void :
	
	Globals.char_turn.run()
	
	disable_buttons(true)


# Toggle buttons state
func disable_buttons(state : bool) -> void :
	
	for i in get_child(0).get_children() :
		
		i.disabled = state
