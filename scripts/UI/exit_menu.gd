extends Control

@export var exit_prompt: Control
@export var stats_menu: Control

func _on_button_button_up() -> void:
	
	var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")
	
	get_parent().get_parent().queue_free()
	
	get_parent().get_parent().get_parent().add_child(main_menu.instantiate())


func _on_exit_button_up() -> void:
	
	exit_prompt.visible = not exit_prompt.visible


func _on_stats_button_up() -> void:
	
	stats_menu.visible = not stats_menu.visible


func _on_close_button_up() -> void:
	
	stats_menu.visible = not stats_menu.visible
