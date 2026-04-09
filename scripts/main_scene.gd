extends Node3D

@export var world_environment : WorldEnvironment
@export var audio_player: AudioStreamPlayer

var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.add_child(main_menu.instantiate())


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
