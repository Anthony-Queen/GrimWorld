extends PanelContainer


@export var offset : Vector2
@export var camera_3d : Camera3D


# Change position to current turn's character
func _on_visibility_changed() -> void :
	
	self.position = camera_3d.unproject_position(Globals.char_turn.position) + offset


# Attack button
func _on_attack_button_up() -> void:
	
	Globals.char_turn.attacking = true
	
	Globals.char_turn.choose_enemy()


# Cast spell button
func _on_spell_button_up() -> void:
	
	Globals.char_turn.choose_enemy()


# Defend button
func _on_defend_button_up() -> void:
	
	Globals.char_turn.defend()


# Use item button
func _on_item_button_up() -> void:
	
	Globals.char_turn.choose_enemy()


# Spare enemy button
func _on_spare_button_up() -> void:
	
	Globals.char_turn.choose_enemy()


# Run away button
func _on_run_button_up() -> void:
	
	Globals.char_turn.run()
