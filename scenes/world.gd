extends Node3D

var ChoiceScene = load("res://scenes/UI/Dialoguechoices.tscn")
func _ready() -> void:
	Globals.choiceScene.connect(_spawn_choice)

func _spawn_choice() -> void:
	add_child(ChoiceScene.instantiate())
