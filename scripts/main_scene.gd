extends Node3D

@export var world_environment : WorldEnvironment
@export var audio_player: AudioStreamPlayer

var main_menu : PackedScene = load("res://Scenes/UI/main_menu.tscn")
var battle : PackedScene = load("res://Scenes/Battle/battle.tscn") 
var world : PackedScene = load("res://Scenes/World/world.tscn")
var player : Player

func _ready() -> void:
	
	Globals.audio_stream_player = $AudioStreamPlayer
	
	Globals.connect("entered_battle", _on_battle_entered)
	Globals.connect("battle_won", _on_battle_won)
	
	if FileAccess.file_exists("user://settings.tres") :
		
		SaveData.settings = ResourceLoader.load("user://settings.tres")
	
	world_environment.environment.adjustment_brightness = SaveData.settings.brightness
	
	audio_player.volume_linear = SaveData.settings.master_sound
	
	add_child(main_menu.instantiate())



func _on_battle_entered() -> void :
	
	SaveData.player_data.position = player.position
	
	get_child(2).queue_free()
	
	add_child(battle.instantiate())
	
	Globals.InBattle = true

func _on_battle_won() -> void :
	
	get_child(2).queue_free()
	
	add_child(world.instantiate())
	
	player.position = SaveData.player_data.position
	
	Globals.reset_enemies()
	
	Globals.turn = 0

func _on_battle_lost() -> void : 
	
	pass
