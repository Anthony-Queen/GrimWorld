extends Node3D




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	Globals.connect("you_lost", _on_you_lost)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _on_you_lost() -> void :
	
	print("dead")
