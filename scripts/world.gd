extends Node3D

var ChoiceScene = load("res://scenes/UI/Dialoguechoices.tscn")
var ExitScene = load("res://scenes/UI/exit_menu.tscn")

var exit_scene : bool = false

func _ready() -> void:
	
	Globals.audio_stream_player.playing = false
	
	Globals.choiceScene.connect(_spawn_choice)

func _spawn_choice() -> void:
	
	add_child(ChoiceScene.instantiate())

func _input(event: InputEvent) -> void :
	
	if event.is_action_released("toggle_exit"):
		
		if exit_scene == false:
			
			get_child(0).add_child(ExitScene.instantiate())
			
			exit_scene = true
		
		elif exit_scene:
			
			get_node("/root/MainScene/World/Player/ExitMenu").queue_free()
			
			exit_scene = false
