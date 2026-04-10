extends Node3D

@export var world_environment : WorldEnvironment
@export var audio_player: AudioStreamPlayer

var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")

func _ready() -> void:
	
	if FileAccess.file_exists("user://settings.tres") :
		
		SaveData.settings = ResourceLoader.load("user://settings.tres")
	
	world_environment.environment.adjustment_brightness = SaveData.settings.brightness / 100
	
	audio_player.volume_linear = SaveData.settings.master_sound / 100
	
	add_child(main_menu.instantiate())
