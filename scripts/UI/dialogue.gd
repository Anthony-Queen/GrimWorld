extends NinePatchRect

#This is so you can have multiple texts one after the other or whatever, you get it bro, making 9 cuz I dont think we'll need more then that?
@export var Text: String
@export var Text2: String
@export var Text3: String
@export var Text4: String
@export var Text5: String
@export var Text6: String
@export var Text7: String
@export var Text8: String
@export var Text9: String

var x: int = 0
var Dialogue: Array = []

func _ready() -> void:
	Dialogue = [Text, Text2, Text3, Text4, Text5, Text6, Text7, Text8, Text9]

func _input(event):
	if event.is_action_pressed("ui_accept"):
		if Dialogue.size() > x :
			change_text()

func change_text():
	# Check if you wrote something in the text, othwerwise finish conversation
	if Dialogue[x] != "":
		$Label.text = Dialogue[x]
		print("Texted")
		x += 1
	else:
		if Globals.isChoiceBeingMade == false:
			Globals.isChoiceBeingMade = true
			make_choice()
			print("Nothing to see here...")

func make_choice():
	
	Globals.choiceScene.emit() # Connects to world.gd
