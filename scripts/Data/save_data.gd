extends Node


var player_data : PlayerData = PlayerData.new() 

var settings : Settings = Settings.new()

var current_data : int = 0

var save_files : int = 0

var load_game : int = 0


@warning_ignore_start("unused_signal")
signal save_requested
signal load_requested
@warning_ignore_restore("unused_signal")


# Calc current save_files to not overwrite them when entering new game
func calc_files() -> void :
	
	save_files = 0
	
	for i in 4 : 
		
		if FileAccess.file_exists("user://save_data" + str(i) + ".tres") :
			
			save_files += 1
			
		
		else :
			
			break
		
		i += 1
