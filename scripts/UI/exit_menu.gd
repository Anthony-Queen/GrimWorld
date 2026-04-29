extends Control

@export var exit_prompt : Control
@export var stats_menu : Control


# Go back to main menu if "yes" is pressed
func _on_button_button_up() -> void :
	
	var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")
	
	get_parent().get_parent().queue_free()
	
	get_parent().get_parent().get_parent().add_child(main_menu.instantiate())


# Show exit prompt if "exit" is pressed
func _on_exit_button_up() -> void :
	
	exit_prompt.visible = not exit_prompt.visible


# Show stats if "stats" pressed
func _on_stats_button_up() -> void :
	
	stats_menu.visible = not stats_menu.visible


# Close menu if "closed" is pressed
func _on_close_button_up() -> void :
	
	stats_menu.visible = not stats_menu.visible
