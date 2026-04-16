extends PanelContainer

@export var offset : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass


func _on_visibility_changed() -> void:
	
	self.position.x = Globals.char_turn.position.x
	self.position.y = Globals.char_turn.position.y


func _on_attack_button_up() -> void:
	
	Globals.char_turn.attack()


func _on_spell_button_up() -> void:
	
	Globals.char_turn.cast_spell()


func _on_defend_button_up() -> void:
	
	Globals.char_turn.defend()


func _on_item_button_up() -> void:
	
	Globals.char_turn.use_item()


func _on_spare_button_up() -> void:
	
	Globals.char_turn.spare()


func _on_run_button_up() -> void:
	
	Globals.char_turn.run()
