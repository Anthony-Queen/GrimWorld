extends Area3D

@onready var player :Player = $"../Player"
@onready var playerCollision : Area3D = $"../Player/PlayerArea"

var current_pos: Vector3
var old_pos: Vector3
var randFloat: float

func _process(_delta: float) -> void :
	
	check_encounter()

func check_encounter() -> void :
	
	set_process(false)
	var timer : SceneTreeTimer = get_tree().create_timer(1.0)
	await timer.timeout
	
	if self in playerCollision.get_overlapping_areas() and player.moving == true:
		
		randFloat = randf()
		
		if randFloat < 0.75:
			
			print("Nothing happened lolz")
		
		else:
			
			await calc_enemies()
			
			print("Random Encounter")
			
			Globals.InBattle = true
			Globals.emit_signal("entered_battle")
	
	set_process(true)

func calc_enemies() :
	
	var enemies_n : int = (randi() % 4) + 1
	
	for i in enemies_n :
		
		var enemy : int = randi() % 2
		
		var enemy_resource = load("res://enemies_resources/enemy" + str(enemy) + ".tres")
		
		Globals.set("current_enemy" + str(i + 1), enemy_resource)
		
		i += 1
