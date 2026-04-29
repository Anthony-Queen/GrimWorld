extends Control


@onready var world_environment : WorldEnvironment = $"/root/MainScene/CanvasEnvironment"
@onready var audio_stream_player : AudioStreamPlayer = $"/root/MainScene/AudioStreamPlayer"


# Settings
@export var brightness : HSlider
@export var master_volume : HSlider


# Load brightness and sound values
func _ready() -> void :
	
	brightness.value = SaveData.settings.brightness
	
	master_volume.value = SaveData.settings.master_sound


# Go back to main menu
func _on_button_button_up() -> void :
	
	var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")
	
	self.queue_free()
	
	get_parent().add_child(main_menu.instantiate()) 
	
	ResourceSaver.save(SaveData.settings, "user://settings.tres")


# Change global brightness value
func _on_brightness_value_changed(value: float) -> void :
	
	SaveData.settings.brightness = value
	
	world_environment.environment.adjustment_brightness = SaveData.settings.brightness 


# Change global sound value
func _on_master_volume_value_changed(value: float) -> void :
	
	SaveData.settings.master_sound = value
	
	audio_stream_player.volume_linear = SaveData.settings.master_sound
