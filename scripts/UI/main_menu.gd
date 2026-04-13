extends Control

func _ready() -> void:
	Globals.audio_stream_player.playing = true
	
	SaveData.calc_files()

func _on_new_game_button_up() -> void :
	
	SaveData.player_data = PlayerData.new() 
	
	var game : PackedScene = load("res://scenes/world.tscn")
	
	self.queue_free()
	
	get_parent().add_child(game.instantiate())
	
	ResourceSaver.save(SaveData.player_data, "user://save_data" + str(SaveData.save_files) + ".tres")
	
	SaveData.current_data = SaveData.save_files

func _on_load_button_up() -> void :
	
	var load_menu : PackedScene = load("res://scenes/UI/load_save.tscn")
	
	self.queue_free()
	
	get_parent().add_child(load_menu.instantiate())
	

func _on_settings_button_up() -> void :
	
	var settings_menu : PackedScene = load("res://scenes/UI/settings.tscn")
	
	self.queue_free()
	
	get_parent().add_child(settings_menu.instantiate())

func _on_exit_button_up() -> void:
	
	get_tree().quit()
