extends Sprite3D

class_name Character

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var your_turn : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.texture = Globals.get("current_char" + str(get_index() + 1)).player_sprite.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if get_index() == Globals.turn :
		
		your_turn = true

func take_damage() :
	
	animation_player.play("hurt")

func attack() :
	
	animation_player.play("attack")
	
	Globals.emit_signal("turn_changed")

func cast_spell() :
	
	animation_player.play("cast")
	
	Globals.emit_signal("turn_changed")

func defend() :
	
	animation_player.play("defend")
	
	Globals.emit_signal("turn_changed")

func use_item() :
	
	animation_player.play("use_item")
	
	Globals.emit_signal("turn_changed")

func spare() :
	
	animation_player.play("spare")
	
	Globals.emit_signal("turn_changed")

func run() :
	
	animation_player.play("run")
	
	Globals.emit_signal("turn_changed")
