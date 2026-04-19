extends PanelContainer

@export var offset : Vector2
@export var camera_3d: Camera3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	pass


func _on_visibility_changed() -> void:
	
	self.position = camera_3d.unproject_position(Globals.char_turn.position) + offset


func _on_attack_button_up() -> void:
	
	Globals.char_turn.attacking = true
	
	Globals.char_turn.choose_enemy()


func _on_spell_button_up() -> void:
	
	Globals.char_turn.choose_enemy()


func _on_defend_button_up() -> void:
	
	Globals.char_turn.defend()


func _on_item_button_up() -> void:
	
	Globals.char_turn.choose_enemy()


func _on_spare_button_up() -> void:
	
	Globals.char_turn.choose_enemy()


func _on_run_button_up() -> void:
	
	Globals.char_turn.run()
