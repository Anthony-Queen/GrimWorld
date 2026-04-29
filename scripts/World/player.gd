extends CharacterBody3D

class_name Player


@export var camera_3d : Camera3D
@export var animation_player : AnimationPlayer
 
# Export sprite to add in battle scene
@export var player_sprite : Sprite3D

# State machine
enum States {idle, running, walking}

var state : States = States.idle : set = set_state

const speed : int = 4 # Movement speed

var direction : Vector2

var moving : bool = false # Check if moving, for random encounters


# Set battle's character
func _ready() -> void :
	
	get_parent().get_parent().player = self 
	
	Globals.current_char1 = self
	Globals.current_char2 = self
	Globals.current_char3 = self
	Globals.current_char4 = self


func _physics_process(_delta: float) -> void :
	
	if not Globals.InBattle :
		
		# Get X and Z axis movement
		
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		velocity.x = (direction.x * speed)
		
		velocity.z = (direction.y * speed)
		
		# Toggle between walking and running state
		if velocity.x == 0 and velocity.z == 0:
			moving = false
			state = States.idle
		
		elif velocity.x < 200 or velocity.z < 200:
			moving = true
			state = States.walking
		
		elif velocity.x >= 200 or velocity.z >= 200:
			moving = true
			state = States.running
		
		move_and_slide()


# Handle states and animations
func set_state(new_state : States) -> void :
	
	var _previous_state: States = state
	
	state = new_state
	
	if state == States.idle :
		
		moving = false
		animation_player.play("idle")
	
	elif state == States.running :
		
		animation_player.play("run")
