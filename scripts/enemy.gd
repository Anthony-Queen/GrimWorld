extends Sprite3D

class_name Enemy

@onready var characters : Node3D = $"../characters"

@export var animation_player: AnimationPlayer

var target_index : int = randi() % 3
var target : Sprite3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func attack() :
	
	target = characters.get_child(target_index)
	
	animation_player.play("attack")
	
	target.take_damage()
