extends Area3D

@onready var player = $"../Player"
@onready var playerCollision = $"../Player/PlayerArea"
var current_pos: Vector3
var old_pos: Vector3
var randFloat: float
var timer = get_tree().create_timer(1.0)


func _physics_process(delta: float) -> void:
	#old_pos = current_pos
	current_pos = Vector3(player.position.y, player.position.z, player.position.x)
	if self in playerCollision.get_overlapping_areas() and player.moving == true and timer.timeout:
		await timer.timeout
		randFloat = randf()
		if randFloat < 0.8:
			print("Nothing happened lolz")
		else:
			print("Random Encounter")
