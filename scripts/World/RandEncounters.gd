extends Area3D


# Player and its area
@onready var player :Player = $"../Player"
@onready var playerCollision : Area3D = $"../Player/PlayerArea"

# variables to handle movement
var current_pos: Vector3
var old_pos: Vector3

# varibles to handle encounter chance
var randFloat: float


# Called at the start, to start loop
func _ready() -> void :
	
	check_encounter()


# Check for encounters
func check_encounter() -> void :
	
	# Create scene timer
	var timer : SceneTreeTimer = get_tree().create_timer(1.0)
	await timer.timeout
	
	# check for movement
	if self in playerCollision.get_overlapping_areas() and player.moving == true :
		
		# Get random float
		randFloat = randf()
		
		# 75% chance to fail
		if randFloat < 0.75 :
			
			print("Nothing happened lolz")
		
		# 25% chance to succed
		else :
			
			# Calc the type and number of enemies
			calc_enemies()
			
			print("Random Encounter")
			
			# Enter battle
			Globals.emit_signal("entered_battle")
	
	# Start over 
	check_encounter()

# Calc enemies and their type
func calc_enemies() -> void :
	
	# Get enemies number
	var enemies_n : int = (randi() % 4) + 1
	
	# Iterate to set sprite and stats
	for i in enemies_n :
		
		# Get enemy type
		var enemy : int = randi() % 2
		
		# Load enemy resource
		var enemy_resource : Resource = load("res://Enemies' Resources/enemy" + str(enemy) + ".tres")
		
		# Set enemy
		Globals.set("current_enemy" + str(i + 1), enemy_resource)
		
		i += 1
