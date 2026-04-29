extends CharacterBody3D

class_name NPC


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var dialogue : Sprite3D = $Dialogue
@onready var SmallDialogue : Sprite3D = $SmallDialogue
@onready var player : Player = $"../Player"

@export var npc_sprite : Sprite3D # Export sprite to add to battle

@export var self_resource : Resource # Enemy resource, containing stats and sprites

@export var max_health : int
@export var weaknesses : Array[String]
@export var shield : int 
@export var speed : int

var pos : Vector3 # Handle distance between player and NPC

var intereactable : bool = false


# Connect to choice signals
func _ready() -> void : 
	
	Globals.connect("choice1", _on_choice_1)
	Globals.connect("choice2", _on_choice_2)


func _physics_process(_delta: float) -> void :
	
	pos = self.position - player.position # Calc distance between player and enemy
	
	# Show dialogue bubble
	if (pos.z < 1 and pos.z > - 1 and pos.x < 1 and pos.x > - 1) :
		
		SmallDialogue.visible = false
		dialogue.visible = true
		intereactable = true
	
	# Hide dialogue bubble
	else :
		
		SmallDialogue.visible = true
		dialogue.visible = false
		intereactable = false


# Enter battle if chosen the first choice
func _on_choice_1() -> void :
	
	Globals.current_enemy3 = self.self_resource
	
	Globals.emit_signal("entered_battle")


func _on_choice_2() -> void :
	
	pass
