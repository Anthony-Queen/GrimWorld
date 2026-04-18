extends Sprite3D

class_name Character


@export var stats: Stats

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemies: Node3D = $"../../Enemies"
@onready var battle_hud: Control = $"../../battle HUD"

var dead : bool = false

var your_turn : bool = false

var class_name_ : String = "Character"

var target_index : int = 0

var target : Enemy

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	self.texture = Globals.get("current_char" + str(get_index() + 1)).player_sprite.texture


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	if get_index() == Globals.turn :
		
		your_turn = true
	
	if your_turn and not dead :
		
		Globals.char_turn = self
		
		self.position.x = 1.5
		
		battle_hud.get_child(1).visible = true
	
	elif your_turn and dead :
		
		Globals.emit_signal("turn_changed", self)
	
	elif not your_turn :
		
		self.position.x = 2.5


func take_damage() :
	
	stats.health.value -= 50
	
	animation_player.play("hurt")
	
	if stats.health.value <= 0 :
		
		dead = true
		
		animation_player.play("dead")

func attack() :
	
	target = enemies.get_child(target_index)
	
	animation_player.play("attack")
	
	target.take_damage()
	
	Globals.emit_signal("turn_changed", self)

func cast_spell() :
	
	stats.mana.value -= 10
	
	animation_player.play("cast")
	
	Globals.emit_signal("turn_changed", self)

func defend() :
	
	animation_player.play("defend")
	
	Globals.emit_signal("turn_changed", self)

func use_item() :
	
	animation_player.play("use_item")
	
	Globals.emit_signal("turn_changed", self)

func spare() :
	
	animation_player.play("spare")
	
	Globals.emit_signal("turn_changed", self)

func run() :
	
	animation_player.play("run")
	
	Globals.emit_signal("turn_changed", self)

func _input(event: InputEvent) -> void:
	
	if event.is_action_released("ui_right") :
		
		target_index += 1
	
	elif event.is_action_released("ui_left") :
		
		target_index -= 1 
