extends CharacterBody3D

class_name Player

@export var animation_player : AnimationPlayer 

const jump_speed : int = -400
const speed : int = 200

enum States {idle, running, jumping, falling, hurt, rolling, dead}

var state: States = States.idle : set = set_state

var direction : float


func _physics_process(delta: float) -> void :
	
	if state != States.dead :
		
		direction = Input.get_axis("move_left", "move_right")
		
		
		if not is_on_floor() :
			
			velocity += get_gravity() * delta
		
		if state not in [States.hurt, States.rolling] :
			
			if velocity.x == 0 :
				
				state = States.idle
			
			if velocity.y > 0 :
				
				state = States.falling
			
			elif velocity.x != 0 and state != States.jumping :
				
				state = States.running
		
		else :
			
			if is_on_floor() :
				
				velocity.x = 0
			
			if state == States.rolling :
				
				pass
				
				#velocity.x = SaveData.player_data.sprite_flipped * speed
		
		move_and_slide()

func set_state(new_state : States) -> void :
	
	var previous_state : States = state
	
	state = new_state
	
	if state == States.idle :
		
		animation_player.play("idle")
	
	elif state == States.jumping :
		
		animation_player.play("jump")
	
	elif previous_state == States.jumping :
		
		animation_player.play("fall")
	
	elif state == States.running :
		
		animation_player.play("run")
	
	elif state == States.hurt :
		
		animation_player.play("hit")
	
	elif state == States.rolling :
		
		animation_player.play("slide")
	
	elif state == States.dead :
		
		animation_player.play("death")
