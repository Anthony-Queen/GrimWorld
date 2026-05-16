extends PanelContainer


@export var offset : Vector2
@export var camera_3d : Camera3D
@export var skill_box: PanelContainer


# Change position to current turn's character
func _on_visibility_changed() -> void :
	
	disable_buttons(false)
	
	if Globals.char_turn.class_name_ == "Character" :
		self.position = camera_3d.unproject_position(Globals.char_turn.position) + offset
		
	await fade_in_left_right()


# Attack or Spells pressed 
func _on_attack_spell_pressed(source: BaseButton) -> void:
	
	skill_box.fade_in_left_right()
	skill_box.set_texts(str(source.name))
	disable_buttons(true)


# Defend button
func _on_defend_button_up() -> void :
	
	Globals.char_turn.defend()
	
	disable_buttons(true)


# Use item button
func _on_item_button_up() -> void :
	
	disable_buttons(true)


# Spare enemy button
func _on_spare_button_up() -> void :
	
	disable_buttons(true)


# Run away button
func _on_run_button_up() -> void :
	
	Globals.char_turn.run()
	
	disable_buttons(true)


# Toggle buttons state
func disable_buttons(state : bool) -> void :
	
	for i in get_child(0).get_children() :
		
		i.disabled = state


# Tween in 
func fade_in_left_right() :
	
	var t1 = get_tree().create_tween()
	var t2 = get_tree().create_tween()
	
	t1.tween_property(self, "size", Vector2(100, 175), 0.3)
	t2.tween_property(self, "modulate", Color(1.0, 1.0, 1.0), 0.3)
	
	await t2.finished


# Tween out
func fade_out_right_left() :
	
	if skill_box.visible :
		
		skill_box.fade_out_right_left()
	
	var t1 = get_tree().create_tween()
	var t2 = get_tree().create_tween()
	
	t1.tween_property(self, "size", Vector2(0, 0), 0.3)
	t2.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.3)
	
	await t2.finished
	self.visible = false
