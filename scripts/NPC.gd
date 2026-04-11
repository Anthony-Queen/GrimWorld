extends CharacterBody3D

class_name NPC

@export var animation_player: AnimationPlayer
@export var dialogue: Sprite3D

@export var max_health : int
@export var speed : int

@onready var player: Player = $"../Player"

var pos : Vector3 

var intereactable : bool = false

func _physics_process(_delta: float) -> void :
	
	pos = self.position - player.position 
	
	if (pos.z < 1 and pos.z > - 1 and pos.x < 1 and pos.x > - 1) :
		
		dialogue.visible = true
		
		intereactable = true
	
	else :
		
		dialogue.visible = false
		
		intereactable = false
