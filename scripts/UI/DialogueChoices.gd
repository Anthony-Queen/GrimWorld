extends Control

func _on_button1_pressed() -> void:
	print("Choice1")
	Globals.choice1.emit()
	Globals.isChoiceBeingMade = false


func _on_button2_pressed() -> void:
	print("Choice2")
	Globals.choice2.emit()
	Globals.isChoiceBeingMade = false
