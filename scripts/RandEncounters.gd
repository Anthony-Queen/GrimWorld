extends Area3D

@onready var player = $"../Player"
@onready var playerCollision = $"../Player/PlayerArea"
var current_pos: Vector3
var old_pos: Vector3
var randFloat: float

func _process(_delta: float) -> void:
	
	check_encounter()

func check_encounter() -> void:
	
	set_process(false)
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	
	if self in playerCollision.get_overlapping_areas() and player.moving == true:
		
		randFloat = randf()
		if randFloat < 0.9:
			
			print("Nothing happened lolz")
		
		else:
			
			print("Random Encounter")
	
	set_process(true)
