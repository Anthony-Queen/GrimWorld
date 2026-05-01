extends Control


# Start soundtrack and calc save files
func _ready() -> void :
	
	if Globals.audio_stream_player.playing == false :
		
		Globals.audio_stream_player.playing = true
	
	SaveData.calc_files()


# Instantiate world scene
func _on_new_game_button_up() -> void :
	
	SaveData.player_data = PlayerData.new() 
	
	var game : PackedScene = load("res://scenes/World/world.tscn")
	
	self.queue_free()
	
	get_parent().add_child(game.instantiate())
	
	ResourceSaver.save(SaveData.player_data, "user://save_data" + str(SaveData.save_files) + ".tres")
	
	SaveData.current_data = SaveData.save_files


# Instantiate load save scene
func _on_load_button_up() -> void :
	
	var load_menu : PackedScene = load("res://Scenes/UI/load_save.tscn")
	
	self.queue_free()
	
	get_parent().add_child(load_menu.instantiate())


# Instantiate settings scene
func _on_settings_button_up() -> void :
	
	var settings_menu : PackedScene = load("res://Scenes/UI/settings.tscn")
	
	self.queue_free()
	
	get_parent().add_child(settings_menu.instantiate())

# Exit game
func _on_exit_button_up() -> void :
	
	get_tree().quit()
