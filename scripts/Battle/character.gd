extends Sprite3D

class_name Character

@export var battle: Node3D

@export var stats : Stats # Export battle hud stats

@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var enemies : Node3D = $"../../Enemies"
@onready var battle_hud : Control = $"../../battle HUD"

# Combat statevariables
var dead : bool = false
var played : bool = false
var choosing : bool = false
var starting_position : Vector3
var attacking_position : Vector3
var your_turn : bool = false
var speed : int

var class_name_ : String = "Character" # Accessible class_name

# Handle target
var target_index : int = 0
var target : Enemy

# Choose attack
var attack : int
var attack_type : String
var attack_or_spell : String

# Assign texture and stats
func _ready() -> void :
	
	self.texture = SaveData.player_data.get("character" + str(self.get_index()) + "_data").character_sprite
	self.position.y = (self.texture.get_height() / 100.00) / 2
	
	stats.health.max_value = SaveData.player_data.get("character" + str(self.get_index()) + "_data").max_health
	stats.health.value = SaveData.player_data.get("character" + str(self.get_index()) + "_data").health
	
	stats.mana.max_value = SaveData.player_data.get("character" + str(self.get_index()) + "_data").max_mana
	stats.mana.value = SaveData.player_data.get("character" + str(self.get_index()) + "_data").mana
	
	self.attack = SaveData.player_data.get("character" + str(self.get_index()) + "_data").damage
	speed = SaveData.player_data.get("character" + str(self.get_index()) + "_data").speed
	
	self.starting_position = position
	self.attacking_position = Vector3(0, starting_position.y, 6)

func _process(_delta: float) -> void :
	
	# Move character forward and make action panel visible
	if your_turn and not dead :
		
		battle.char_attacking = self
		
		self.position = attacking_position
		
		battle_hud.get_child(1).visible = true
	
	# Change turn if deaad
	elif your_turn and dead :
		
		battle.emit_signal("turn_changed", self)
	
	# Move character backwards
	elif not your_turn :
		
		self.position = starting_position
	
	# Check for killed enemies
	if enemies.get_child_count() == 0 and battle.in_battle == true :
		
		battle.in_battle = false
		
		battle.emit_signal("battle_won")


# Take damage and check dead conditions
func take_damage(attacker : Enemy) -> void :
	
	stats.health.value -= attacker.attack
	SaveData.player_data.get("character" + str(self.get_index()) + "_data").health = stats.health.value 
	
	animation_player.play("hurt")
	
	if stats.health.value <= 0 :
		
		dead = true
		
		battle.dead_characters += 1
		
		animation_player.play("dead")


# Attack
func attacks() -> void :
	
	var attack_resource : Resource = ResourceLoader.load("res://AttacksResources/attacks/" + attack_type + ".tres")
	
	animation_player.play(attack_type)
	
	target.take_damage(attack_resource.damage, attack_resource.type)
	
	choosing = false
	
	battle.emit_signal("turn_changed", self)


# Cast spell
func spells() -> void :
	
	var attack_resource : Resource = ResourceLoader.load("res://AttacksResources/spells/" + attack_type + ".tres")
	
	stats.mana.value -= 10
	SaveData.player_data.get("character" + str(self.get_index()) + "_data").mana = stats.mana.value 
	
	animation_player.play(attack_type)
	
	target.take_damage(attack_resource.damage, attack_resource.type)
	
	choosing = false
	
	battle.emit_signal("turn_changed", self)


# Defend
func defend() -> void :
	
	animation_player.play("defend")
	
	battle.emit_signal("turn_changed", self)
	
	played = true


# Use item
func use_item() -> void :
	
	animation_player.play("use_item")
	
	battle.emit_signal("turn_changed", self)


# Spare enemy
func spare() -> void :
	
	animation_player.play("spare")
	
	battle.emit_signal("turn_changed", self)


# Run away
func run() -> void :
	
	animation_player.play("run")
	
	battle.emit_signal("turn_changed", self)
	
	played = true


# Begin choosing-target phase
func choose_enemy(spell_or_attack : String, attack_chosen : String) -> void :
	
	if not choosing :
		
		attack_or_spell = spell_or_attack
		attack_type = attack_chosen
		
		choosing = true
		
		target_index = 0
		
		target = enemies.get_child(target_index)
		
		target.selector_sprite.visible = true
		
		target.health_sprite.visible = false


# Get input to chance target
func _input(event: InputEvent) -> void :
	
	# If right key pressed, selector goes to previous enemy
	if event.is_action_pressed("ui_right") and choosing and target_index != (enemies.get_child_count() - 1) :
		
		target = enemies.get_child(target_index)
		target.selector_sprite.visible = false
		target.health_sprite.visible = true
		
		target_index += 1
		
		target = enemies.get_child(target_index)
		target.selector_sprite.visible = true
		target.health_sprite.visible = false
	
	# If left key pressed, selector goes to next enemy
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
		
		self.call(attack_or_spell)
		
		self.played = true
