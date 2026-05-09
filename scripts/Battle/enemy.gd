extends Sprite3D

class_name Enemy


@export var health_sprite : Sprite3D
@export var health_bar : TextureProgressBar
@export var camera_3d : Camera3D
@export var timer : Timer

@export var hp_offset : Vector2

@onready var characters : Node3D = $"../../Characters" # Character's node

@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Combat variables
var your_turn : bool = false
var starting_position : Vector3
var attacking_position : Vector3
var attacked : bool = false
var attack : int

var class_name_ : String = "Enemy" # Accessible class_name

var target : Sprite3D # Target


# Get enemy data, stats, and sprite if existent
func _ready() -> void :
	
	if Globals.get("current_enemy" + str(get_index() + 1)) :
		
		self.texture = Globals.get("current_enemy" + str(get_index() + 1)).texture
		self.attack = Globals.get("current_enemy" + str(get_index() + 1)).attack
		
		health_bar.max_value = Globals.get("current_enemy" + str(get_index() + 1)).health
		health_bar.value = Globals.get("current_enemy" + str(get_index() + 1)).health
		
		self.position.y = (self.texture.get_height() / 100.00) / 2
		
		# Set position when out of turn and when attacking
		self.starting_position = position
		self.attacking_position = Vector3(0, starting_position.y, starting_position.z)
		
		# Set hp bar offset position
		self.hp_offset.y = - (self.texture.get_height() / 4.0) / 100
		self.hp_offset.x = - (self.texture.get_width() / 2.0) / 100
		
		health_sprite.visible = true
	
	# Free if no current enemy
	else : 
		
		self.queue_free()


func _process(_delta: float) -> void:
	
	_on_health_visibility_changed() # Change health position
	
	# Check turn
	if (get_index() + 4) == Globals.turn :
		
		your_turn = true
	
	# Move enemy forward and attack if it's its turn
	if your_turn :
		
		self.position = attacking_position
		
		if attacked == false :
			
			self._attack()
	
	# Move enemy backwards
	else :
		
		self.position = starting_position


# Take damage and check if dead
func take_damage(attacker : Character) -> void :
	
	health_bar.value -= attacker.attack
	
	animation_player.play("hurt")
	
	if health_bar.value <= 0 :
		
		animation_player.play("dead")
		
		queue_free()


# Attack and calc target
func _attack() -> void :
	
	self.attacked = true # To not repeat more than 1 per turn
	
	var target_index : int = randi() % 4 # get random target index
	
	target = characters.get_child(target_index) # Get target
	
	# Change target if current is dead
	while target.dead == true :
		
		target_index = randi() % 4
		
		target = characters.get_child(target_index)
	
	timer.start() # Start timer


# Make target take damage
func _on_timer_timeout() -> void:
	
	target.take_damage(self)
	
	animation_player.play("attack")
	
	Globals.emit_signal("turn_changed", self)
	
	self.attacked = false


# Change health position
func _on_health_visibility_changed() -> void:
	
	health_sprite.position.y = hp_offset.y - 0.2
	health_sprite.position.x = hp_offset.x - 0.2
