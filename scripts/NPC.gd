extends CharacterBody3D

class_name NPC

@export var max_health : int
@export var speed : int

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var dialogue: Sprite3D = $Dialogue
@onready var SmallDialogue: Sprite3D = $SmallDialogue
@onready var player: Player = $"../Player"

var pos : Vector3 

var intereactable : bool = false

func _ready() -> void: 
	
	Globals.connect("choice1", _on_choice_1)
	Globals.connect("choice2", _on_choice_2)

func _physics_process(_delta: float) -> void :
	pos = self.position - player.position
	
	if (pos.z < 1 and pos.z > - 1 and pos.x < 1 and pos.x > - 1) :
		SmallDialogue.visible = false
		dialogue.visible = true
		intereactable = true
	
	else :
		SmallDialogue.visible = true
		dialogue.visible = false
		intereactable = false

func _on_choice_1() :
	
	var battle_scene : PackedScene = load("res://scenes/arena_3d.tscn")
	
	get_parent().queue_free()
	
	get_parent().get_parent().add_child(battle_scene.instantiate()) 

func _on_choice_2() :
	
	pass
