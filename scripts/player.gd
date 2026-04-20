extends CharacterBody3D

class_name Player

@export var camera_3d: Camera3D
@export var animation_player : AnimationPlayer
 
@export var player_sprite: Sprite3D
enum States {idle, running, walking, attacking, hurt, dead}

var state: States = States.idle : set = set_state

const speed : int = 4

var direction : Vector2
var directionz
var moving: bool = false

func _ready() -> void:
	
	Globals.current_char1 = self
	Globals.current_char2 = self
	Globals.current_char3 = self
	Globals.current_char4 = self


func _physics_process(_delta: float) -> void :  #Need to add state walking
	
	if state != States.dead and Globals.InBattle == false :
		
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		directionz = Input.get_axis("move_up", "move_down")
		
		velocity.x = (direction.x * speed)
		
		velocity.z = (directionz * speed)
		
		if state != States.hurt :
			
			if velocity.x == 0 and velocity.z == 0:
				moving = false
				state = States.idle

			elif velocity.x < 200 or velocity.z < 200:
				moving = true
				state = States.walking
			
			elif velocity.x >= 200 or velocity.z >= 200:
				moving = true
				state = States.running
		
		else :
			
			if is_on_floor() :
				
				velocity.x = 0
		
		move_and_slide()

func set_state(new_state : States) -> void :
	
	var _previous_state: States = state
	
	state = new_state
	
	if state == States.idle :
		moving = false
		animation_player.play("idle")
	
	elif state == States.running :
		
		animation_player.play("run")
	
	elif state == States.hurt :
		
		animation_player.play("hit")
	
	elif state == States.dead :
		
		animation_player.play("death")
