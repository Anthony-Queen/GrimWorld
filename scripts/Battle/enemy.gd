extends Sprite3D

class_name Enemy

@export var health: TextureProgressBar
@export var camera_3d: Camera3D
@export var timer: Timer

@export var hp_offset : Vector2

@onready var characters : Node3D = $"../../Characters"

@onready var animation_player: AnimationPlayer = $AnimationPlayer

var class_name_ : String = "Enemy"

var target : Sprite3D

var your_turn : bool = false

var attacked : bool = false

var attack : int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	if Globals.get("current_enemy" + str(get_index() + 1)) :
		
		self.texture = Globals.get("current_enemy" + str(get_index() + 1)).texture
		self.scale = Globals.get("current_enemy" + str(get_index() + 1)).scale
		self.attack = Globals.get("current_enemy" + str(get_index() + 1)).attack
		
		health.max_value = Globals.get("current_enemy" + str(get_index() + 1)).health
		health.value = Globals.get("current_enemy" + str(get_index() + 1)).health
		
		health.visible = true
	
	else : 
		
		self.queue_free()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	_on_health_visibility_changed()
	
	if (get_index() + 4) == Globals.turn :
		
		your_turn = true
	
	if your_turn :
		
		if attacked == false :
			
			self._attack()
		
		self.position.x = -1.5
	
	else :
		
		self.position.x = -2.5


func take_damage(attacker : Character) -> void :
	
	health.value -= attacker.attack
	
	animation_player.play("hurt")
	
	if health.value <= 0 :
		
		animation_player.play("dead")
		
		queue_free()

func _attack() -> void :
	
	self.attacked = true 
	
	var target_index : int = randi() % 4
	
	target = characters.get_child(target_index)
	
	while target.dead == true :
		
		target_index = randi() % 4
		
		target = characters.get_child(target_index)
	
	timer.start()


func _on_timer_timeout() -> void:
	
	target.take_damage(self)
	
	animation_player.play("attack")
	
	Globals.emit_signal("turn_changed", self)
	
	self.attacked = false


func _on_health_visibility_changed() -> void:
	
	health.position = (camera_3d.unproject_position(self.position) + hp_offset)
	
	health.position.y -= (self.position.z * 10)
	health.position.x += (self.position.z)
