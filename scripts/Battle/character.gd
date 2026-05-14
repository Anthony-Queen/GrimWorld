extends Sprite3D

class_name Character


@export var stats : Stats # Export battle hud stats

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var enemies : Node3D = $"../../Enemies"
@onready var battle_hud : Control = $"../../battle HUD"

# Combat statevariables
var dead : bool = false
var attacking : bool = false
var attack : int
var choosing : bool = false
var starting_position : Vector3
var attacking_position : Vector3
var your_turn : bool = false

var class_name_ : String = "Character" # Accessible class_name

# Handle target
var target_index : int = 0
var target : Enemy

# Assign texture and stats
func _ready() -> void :
	
	self.texture = Globals.get("current_char" + str(get_index() + 1)).player_sprite.texture
	self.position.y = (self.texture.get_height() / 100.00) / 2
	
	stats.health.max_value = SaveData.player_data.get("character" + str(self.get_index()) + "_data").max_health
	stats.health.value = SaveData.player_data.get("character" + str(self.get_index()) + "_data").health
	
	stats.mana.max_value = SaveData.player_data.get("character" + str(self.get_index()) + "_data").max_mana
	stats.mana.value = SaveData.player_data.get("character" + str(self.get_index()) + "_data").mana
	
	self.attack = SaveData.player_data.get("character" + str(self.get_index()) + "_data").damage
	
	self.starting_position = position
	self.attacking_position = Vector3(0, starting_position.y, 6)

func _process(_delta: float) -> void :
	
	# Check turn
	if get_index() == Globals.turn :
		
		your_turn = true
	
	# Move character forward and make action panel visible
	if your_turn and not dead :
		
		Globals.char_turn = self
		
		self.position = attacking_position
		
		battle_hud.get_child(1).visible = true
	
	# Change turn if deaad
	elif your_turn and dead :
		
		Globals.emit_signal("turn_changed", self)
	
	# Move character backwards
	elif not your_turn :
		
		self.position = starting_position
	
	# Check for killed enemies
	if enemies.get_child_count() == 0 and Globals.InBattle == true :
		
		Globals.InBattle = false
		
		Globals.emit_signal("battle_won")


# Take damage and check dead conditions
func take_damage(attacker : Enemy) -> void :
	
	stats.health.value -= attacker.attack
	SaveData.player_data.get("character" + str(self.get_index()) + "_data").health = stats.health.value 
	
	animation_player.play("hurt")
	
	if stats.health.value <= 0 :
		
		dead = true
		
		Globals.dead_characters += 1
		
		animation_player.play("dead")


# Attack
func _attack() -> void :
	
	animation_player.play("attack")
	
	target.take_damage(self)
	
	attacking = false
	
	choosing = false
	
	Globals.emit_signal("turn_changed", self)


# Cast spell
func cast_spell() -> void :
	
	stats.mana.value -= 10
	SaveData.player_data.get("character" + str(self.get_index()) + "_data").mana = stats.mana.value 
	
	animation_player.play("cast")
	
	Globals.emit_signal("turn_changed", self)


# Defend
func defend() -> void :
	
	animation_player.play("defend")
	
	Globals.emit_signal("turn_changed", self)


# Use item
func use_item() -> void :
	
	animation_player.play("use_item")
	
	Globals.emit_signal("turn_changed", self)


# Spare enemy
func spare() -> void :
	
	animation_player.play("spare")
	
	Globals.emit_signal("turn_changed", self)


# Run away
func run() -> void :
	
	animation_player.play("run")
	
	Globals.emit_signal("turn_changed", self)


# Begin choosing-target phase
func choose_enemy() -> void :
	
	if not choosing :
		
		choosing = true
		
		target_index = 0
		
		target = enemies.get_child(target_index)
		
		target.selector_sprite.visible = true
		
		target.health_sprite.visible = false


# Get input to chance target
func _input(event: InputEvent) -> void :
	
	# If right key pressed, selector goes to previous enemy (behind)
	if event.is_action_pressed("ui_right") and choosing and target_index != (enemies.get_child_count() - 1) :
		
		target = enemies.get_child(target_index)
		target.selector_sprite.visible = false
		target.health_sprite.visible = true
		
		target_index += 1
		
		target = enemies.get_child(target_index)
		target.selector_sprite.visible = true
		target.health_sprite.visible = false
	
	# If left key pressed, selector goes to next enemy (in front)
	elif event.is_action_pressed("ui_left") and choosing and target_index != 0 :
		
		target = enemies.get_child(target_index)
		target.selector_sprite.visible = false
		target.health_sprite.visible = true
		
		target_index -= 1
		
		target = enemies.get_child(target_index)
		target.selector_sprite.visible = true
		target.health_sprite.visible = false
	
	# Confirm action if enter is pressed
	elif event.is_action_pressed("ui_accept") and choosing :
		
		target.selector_sprite.visible = false
		target.health_sprite.visible = true
		
		if attacking :
			
			_attack()
