extends Node3D

var ChoiceScene = load("res://scenes/UI/Dialoguechoices.tscn")
var ExitScene = load("res://scenes/UI/exit_menu.tscn")

var exit_scene : int = 0

func _ready() -> void:
	
	Globals.choiceScene.connect(_spawn_choice)

func _spawn_choice() -> void:
	
	add_child(ChoiceScene.instantiate())

func _input(event: InputEvent) -> void :
	
	if event.is_action_released("toggle_exit") :
		
		if exit_scene == 0 :
			
			get_child(0).add_child(ExitScene.instantiate())
			
			exit_scene = 1
		
		else :
			
			get_node("/root/MainScene/World/Player/ExitMenu").queue_free()
			
			exit_scene = 0
