extends Control

func _on_button_pressed() -> void:
	
	print("Choice1")
	
	Globals.choice1.emit()
	
	Globals.is_choice_being_made = false
	
	self.queue_free()


func _on_button_2_pressed() -> void:
	
	print("Choice2")
	
	Globals.choice2.emit()
	
	Globals.is_choice_being_made = false
	
	self.queue_free()
