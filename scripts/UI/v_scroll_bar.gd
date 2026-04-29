extends VScrollBar

@export var node_2d : Node2D


# Change visible load save
func _on_value_changed(_value: float) -> void :
	
	node_2d.position.y = -_value


# Get scroll input
func _input(event: InputEvent) -> void :
	
	if event.is_action_released("scroll_down") :
		
		value += 25
	
	elif event.is_action_released("scroll_up") :
		
		value -= 25
