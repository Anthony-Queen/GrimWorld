extends Sprite3D

class_name Enemy

@onready var characters : Node3D = $"../../Characters"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var class_name_ : String = "Enemy"

var target_index : int = randi() % 3
var target : Sprite3D

var your_turn : bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.texture = Globals.get("current_char" + str(get_index() + 1)).player_sprite.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if (get_index() + 4) == Globals.turn :
		
		your_turn = true
	
	if your_turn == true :
		
		self.position.x = -1.5
		
		attack()
	
	else :
		
		self.position.x = -2.5


func take_damage() :
	
	animation_player.play("hurt")


func attack() :
	
	target = characters.get_child(target_index)
	
	target.take_damage()
	
	animation_player.play("attack")
	
	Globals.emit_signal("turn_changed", self)
