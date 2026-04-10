extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_button_button_up() -> void:
	
	var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")
	
	self.queue_free()
	
	get_parent().add_child(main_menu.instantiate()) # This doesn't work! *Slaps you with a trout*
