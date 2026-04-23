extends Sprite3D

class_name Character


@export var stats: Stats

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var enemies: Node3D = $"../../Enemies"
@onready var battle_hud: Control = $"../../battle HUD"

@onready var selector : PackedScene = load("res://scenes/UI/selector.tscn")

var dead : bool = false

var attacking : bool = false

var choosing : bool = false

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


func take_damage() -> void :
	
	stats.health.value -= 50
	
	animation_player.play("hurt")
	
	if stats.health.value <= 0 :
		
		dead = true
		
		Globals.dead += 1
		
		animation_player.play("dead")

func attack() -> void :
	
	animation_player.play("attack")
	
	target.take_damage()
	
	attacking = false
	
	choosing = false
	
	Globals.emit_signal("turn_changed", self)

func cast_spell() -> void :
	
	stats.mana.value -= 10
	
	animation_player.play("cast")
	
	Globals.emit_signal("turn_changed", self)

func defend() -> void :
	
	animation_player.play("defend")
	
	Globals.emit_signal("turn_changed", self)

func use_item() -> void :
	
	animation_player.play("use_item")
	
	Globals.emit_signal("turn_changed", self)

func spare() -> void :
	
	animation_player.play("spare")
	
	Globals.emit_signal("turn_changed", self)

func run() -> void :
	
	animation_player.play("run")
	
	Globals.emit_signal("turn_changed", self)

func choose_enemy() -> void :
	
	if not choosing :
		
		choosing = true
		
		target_index = 0
		
		target = enemies.get_child(target_index)
		
		target.add_child(selector.instantiate())
		
		target.health.visible = false

func _input(event: InputEvent) -> void:
	
	if event.is_action_released("ui_right") and choosing and target_index != 0 :
		
		target = enemies.get_child(target_index)
		target.get_child(3).queue_free()
		target.health.visible = true
		
		target_index -= 1
		
		target = enemies.get_child(target_index)
		target.add_child(selector.instantiate())
		target.health.visible = false
	
	elif event.is_action_released("ui_left") and choosing and target_index != (target.get_parent().get_child_count() - 1) :
		
		target = enemies.get_child(target_index)
		target.get_child(3).queue_free()
		target.health.visible = true
		
		target_index += 1
		
		target = enemies.get_child(target_index)
		target.add_child(selector.instantiate())
		target.health.visible = false
	
	elif event.is_action_released("ui_accept") and choosing :
		
		target.get_child(3).queue_free()
		target.health.visible = true
		
		if attacking :
			
			attack()
