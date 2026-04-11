extends Control


func _on_button_button_up() -> void:
	
	var main_menu : PackedScene = load("res://scenes/UI/main_menu.tscn")
	
	get_parent().get_parent().queue_free()
	
	get_parent().get_parent().get_parent().add_child(main_menu.instantiate())
