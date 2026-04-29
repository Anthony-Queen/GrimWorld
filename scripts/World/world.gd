extends Node3D

# Load exit and dialogue scenes
var ChoiceScene : PackedScene = load("res://scenes/UI/Dialoguechoices.tscn")
var ExitScene : PackedScene = load("res://scenes/UI/exit_menu.tscn")

# Keep track of instanced exit scene
var exit_scene : bool = false


# Called to stop menu's soundtrack and connect to choice signal
func _ready() -> void :
	
	Globals.audio_stream_player.playing = false
	
	Globals.choice_scene.connect(_spawn_choice)


# Instantiate choice scene
func _spawn_choice() -> void :
	
	add_child(ChoiceScene.instantiate())


# Toggle exit menu
func _input(event: InputEvent) -> void :
	
	if event.is_action_released("toggle_exit"):
		
		if exit_scene == false :
			
			get_child(0).add_child(ExitScene.instantiate())
			
			exit_scene = true
		
		elif exit_scene :
			
			get_node("/root/MainScene/World/Player/ExitMenu").queue_free()
			
			exit_scene = false
