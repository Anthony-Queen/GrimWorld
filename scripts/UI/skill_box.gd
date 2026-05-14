extends PanelContainer

func set_texts(node_name : String) -> void :
	
	var n : int = 0
	
	for i in self.get_child(0).get_children() :
		
		i.text = SaveData.player_data.get("character" + str(Globals.char_turn.get_index()) + "_data").get(node_name)[n]
		
		n += 1

# Tween in 
func fade_in_left_right() :
	
	self.visible = true
	
	var t1 = get_tree().create_tween()
	var t2 = get_tree().create_tween()
	
	t1.tween_property(self, "size", Vector2(134, 175), 0.25)
	t2.tween_property(self, "modulate", Color(1.0, 1.0, 1.0), 0.25)
	
	await t2.finished

# Tween out
func fade_out_right_left() :
	
	var t1 = get_tree().create_tween()
	var t2 = get_tree().create_tween()
	
	t1.tween_property(self, "size", Vector2(0, 0), 0.25)
	t2.tween_property(self, "modulate", Color(1.0, 1.0, 1.0, 0.0), 0.25)
	
	await t2.finished
	self.visible = false
