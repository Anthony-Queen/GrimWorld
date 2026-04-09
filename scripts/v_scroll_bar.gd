extends VScrollBar

@export var node_2d: Node2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_value_changed(_value: float) -> void:
	
	node_2d.position.y = -_value

func _input(event: InputEvent) -> void:
	
	if event.is_action_released("scroll_down") :
		
		value += 25
	
	elif event.is_action_released("scroll_up") :
		
		value -= 25
