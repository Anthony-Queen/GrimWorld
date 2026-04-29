extends Sprite3D

class_name Enemy


@export var health : TextureProgressBar
@export var camera_3d : Camera3D
@export var timer : Timer

@export var hp_offset : Vector2

@onready var characters : Node3D = $"../../Characters" # Character's node

@onready var animation_player : AnimationPlayer = $AnimationPlayer

# Combat variables
var your_turn : bool = false
var attacked : bool = false
var attack : int

var class_name_ : String = "Enemy" # Accessible class_name

var target : Sprite3D # Target


# Get enemy data, stats, and sprite if existent
func _ready() -> void:
	
	if Globals.get("current_enemy" + str(get_index() + 1)) :
		
		self.texture = Globals.get("current_enemy" + str(get_index() + 1)).texture
		self.scale = Globals.get("current_enemy" + str(get_index() + 1)).scale
		self.attack = Globals.get("current_enemy" + str(get_index() + 1)).attack
		
		health.max_value = Globals.get("current_enemy" + str(get_index() + 1)).health
		health.value = Globals.get("current_enemy" + str(get_index() + 1)).health
		
		health.visible = true
	
	
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
		
		if attacked == false :
			
			self._attack()
		
		self.position.x = -1.5
	
	# Move enemy backwards
	else :
		
		self.position.x = -2.5


# Take damage and check if dead
func take_damage(attacker : Character) -> void :
	
	health.value -= attacker.attack
	
	animation_player.play("hurt")
	
	if health.value <= 0 :
		
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
	
	health.position = (camera_3d.unproject_position(self.position) + hp_offset)
	
	health.position.y -= (self.position.z * 10)
	health.position.x += (self.position.z)
