extends PanelContainer

@export var battle: Node3D

@export var back_button : Button
@export var action_box : PanelContainer

var attack_or_spell : String 

func set_texts(node_name : String) -> void :
	
	attack_or_spell = node_name
	
	var n : int = 0
	
	for i in self.get_child(0).get_children() :
		
		if SaveData.player_data.get("character" + str(battle.char_attacking.get_index()) + "_data").get(node_name).size() > n :
			i.disabled = false
			i.flat = false
			i.text = SaveData.player_data.get("character" + str(battle.char_attacking.get_index()) + "_data").get(node_name)[n]
		
		else :
			i.disabled = true
			i.flat = true
		
		n += 1


# Tween in and take action chosen
func fade_in_left_right() :
	
	self.visible = true
	back_button.visible = true
	back_button.disabled = false
	
	var t1 = get_tree().create_tween()
	var t2 = get_tree().create_tween()
	
	t1.tween_property(self, "size", Vector2(134, 175), 0.25)
	t1.set_parallel()
	t1.tween_property(back_button, "size", Vector2(33, 31), 0.25)
	
	t2.tween_property(self, "modulate", Color(1.0, 1.0, 1.0), 0.25)
	t2.set_parallel()
	t2.tween_property(back_button, "modulate", Color(1.0, 1.0, 1.0), 0.25)
	
	await t2.finished


# Tween out
func fade_out_right_left() :
	
	action_box.disable_buttons(false)
	
	var t1 = get_tree().create_tween()
	var t2 = get_tree().create_tween()
	
	t1.tween_property(self, "size", Vector2(0, 175), 0.25)
	t1.set_parallel()
	t1.tween_property(back_button, "size", Vector2(0, 31), 0.25)
	
	t2.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.25)
	t2.set_parallel()
	t2.tween_property(back_button, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.25)
	
	await t2.finished
	self.visible = false
	back_button.visible = false



func _on_attack_or_spell_chosen(source: BaseButton) -> void:
	
	battle.char_attacking.choose_enemy(attack_or_spell, source.text)
	back_button.disabled = true
