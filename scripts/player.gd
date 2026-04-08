extends CharacterBody3D

class_name Player

@export var animation_player : AnimationPlayer 

enum States {idle, running, walking, hurt, rolling, dead}

var state: States = States.idle : set = set_state

const speed : int = 4

var direction : Vector2

func _physics_process(_delta: float) -> void :  #Need to add state walking
	
	if state != States.dead :
		
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		velocity.x = direction.x * speed
		
		velocity.z = direction.y * speed
		
		if state not in [States.hurt, States.rolling] :
			
			if velocity.x == 0 :
				
				state = States.idle
			
			elif velocity.x < 200:
				
				state = States.walking
			
			elif velocity.x >= 200:
				
				state = States.running
		
		else :
			
			if is_on_floor() :
				
				velocity.x = 0
			
			if state == States.rolling :
				
				pass
				
				#velocity.x = SaveData.player_data.sprite_flipped * speed
		
		move_and_slide()

func set_state(new_state : States) -> void :
	
	var _previous_state: States = state
	
	state = new_state
	
	if state == States.idle :
		
		animation_player.play("idle")
	
	elif state == States.running :
		
		animation_player.play("run")
	
	elif state == States.hurt :
		
		animation_player.play("hit")
	
	elif state == States.rolling :
		
		animation_player.play("slide")
	
	elif state == States.dead :
		
		animation_player.play("death")
