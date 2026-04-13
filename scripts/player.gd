extends CharacterBody3D

class_name Player

@export var animation_player : AnimationPlayer 

enum States {idle, running, walking, attacking, hurt, dead}

var state: States = States.idle : set = set_state

const speed : int = 4

var direction : Vector2

func _ready() -> void:
	
	Globals.connect("entered_battle", _on_battle_entered)

func _physics_process(_delta: float) -> void :  #Need to add state walking
	
	if state != States.dead and Globals.InBattle == false :
		
		direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
		
		velocity.x = (direction.x * speed)
		
		velocity.z = direction.y * speed
		
		if state != States.hurt :
			
			if velocity.x == 0 :
				
				state = States.idle
			
			elif velocity.x < 200:
				
				state = States.walking
			
			elif velocity.x >= 200:
				
				state = States.running
		
		else :
			
			if is_on_floor() :
				
				velocity.x = 0
		
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
	
	elif state == States.dead :
		
		animation_player.play("death")


func _on_battle_entered() :
	
	pass
