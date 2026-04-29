extends Control


# Instantiate world scene and load save
func change_scene_to_game(n_save : int) -> void : 
	
	var game : PackedScene = load("res://scenes/world.tscn")
	
	self.queue_free()
	
	get_parent().add_child(game.instantiate())
	
	SaveData.current_data = n_save
	
	SaveData.load_game = 1


# Go back to main menu
func _on_button_button_up() -> void :
	
	var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")
	
	self.queue_free()
	
	get_parent().add_child(main_menu.instantiate())


# Select save 1
func _on_load_0_button_up() -> void :
	
	change_scene_to_game(0)


# Select save 2
func _on_load_1_button_up() -> void :
	
	change_scene_to_game(1)


# Select save 3
func _on_load_2_button_up() -> void :
	
	change_scene_to_game(2)


# Select save 4
func _on_load_3_button_up() -> void :
	
	change_scene_to_game(3)


# Select save 5
func _on_load_4_button_up() -> void :
	
	change_scene_to_game(4)


# Select save 6
func _on_load_5_button_up() -> void :
	
	change_scene_to_game(5)


# Select save 7
func _on_load_6_button_up() -> void :
	
	change_scene_to_game(6)


# Select save 8
func _on_load_7_button_up() -> void :
	
	change_scene_to_game(7)


# Select save 9
func _on_load_8_button_up() -> void :
	
	change_scene_to_game(8)


# Select save 10
func _on_load_9_button_up() -> void :
	
	change_scene_to_game(9)
