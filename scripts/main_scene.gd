extends Node3D

@export var world_environment : WorldEnvironment
@export var audio_player: AudioStreamPlayer

var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")
var battle : PackedScene = load("res://scenes/battle.tscn")

func _ready() -> void:
	
	Globals.audio_stream_player = $AudioStreamPlayer
	
	Globals.connect("entered_battle", _on_battle_entered)
	
	if FileAccess.file_exists("user://settings.tres") :
		
		SaveData.settings = ResourceLoader.load("user://settings.tres")
	
	world_environment.environment.adjustment_brightness = SaveData.settings.brightness
	
	audio_player.volume_linear = SaveData.settings.master_sound
	
	add_child(main_menu.instantiate())



func _on_battle_entered(enemies : Array[Enemy]) -> void :
	
	get_child(2).queue_free()
	
	add_child(battle.instantiate())
