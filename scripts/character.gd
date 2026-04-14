extends Sprite3D

class_name Character

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func take_damage() :
	
	animation_player.play("hurt")

func attack() :
	
	animation_player.play("attack")

func cast_spell() :
	
	animation_player.play("cast")

func defend() :
	
	animation_player.play("defend")

func use_item() :
	
	animation_player.play("use_item")

func spare() :
	
	animation_player.play("spare")

func run() :
	
	animation_player.play("run")
