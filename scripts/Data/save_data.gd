extends Node

var player_data : PlayerData = PlayerData.new() 

var settings : Settings = Settings.new()

var current_data : int = 0

var save_files : int = 0

var load_game : int = 0

@warning_ignore("unused_signal")
signal save_requested
@warning_ignore("unused_signal")
signal load_requested

func calc_files() -> void :
	
	save_files = 0
	
	for i in 4 : 
		
		if FileAccess.file_exists("user://save_data" + str(i) + ".tres") :
			
			save_files += 1
			
		
		else :
			
			break
		
		i += 1
