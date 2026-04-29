extends Node3D

@export var world_environment : WorldEnvironment
@export var audio_player : AudioStreamPlayer

# Load scenes to instantiate
var MainMenu : PackedScene = load("res://Scenes/UI/main_menu.tscn")
var Battle : PackedScene = load("res://Scenes/Battle/battle.tscn") 
var World : PackedScene = load("res://Scenes/World/world.tscn")


var player : Player


func _ready() -> void:
	
	Globals.audio_stream_player = $AudioStreamPlayer
	
	# Connect to battle signals
	Globals.connect("entered_battle", _on_battle_entered)
	Globals.connect("battle_won", _on_battle_won)
	
	# Check for setting's files
	if FileAccess.file_exists("user://settings.tres") :
		
		SaveData.settings = ResourceLoader.load("user://settings.tres")
	
	# set brightness and sound settings
	world_environment.environment.adjustment_brightness = SaveData.settings.brightness
	
	audio_player.volume_linear = SaveData.settings.master_sound
	
	add_child(MainMenu.instantiate())


# Called when battle is entered, to instiantiate the battle scene and save the player's current position
func _on_battle_entered() -> void :
	
	SaveData.player_data.position = player.position
	
	get_child(2).queue_free()
	
	add_child(Battle.instantiate())
	
	Globals.InBattle = true


# Called when battle is won, to instiantiate the world scene, load the player's previous position and reset enemies
func _on_battle_won() -> void :
	
	get_child(2).queue_free()
	
	add_child(World.instantiate())
	
	player.position = SaveData.player_data.position
	
	Globals.reset_enemies()
	
	Globals.turn = 0

# Need to add loosing conditions
func _on_battle_lost() -> void : 
	
	pass
