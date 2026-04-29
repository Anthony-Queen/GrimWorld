extends NinePatchRect


# Text lines
@export var Text : String
@export var Text2 : String
@export var Text3 : String
@export var Text4 : String
@export var Text5 : String
@export var Text6 : String
@export var Text7 : String
@export var Text8 : String
@export var Text9 : String

# NPC
@export var npc : NPC

# Handle dialogue progression and choices
var x : int = 0
var choice_made : bool = false
var Dialogue : Array = []


# Set text lines
func _ready() -> void :
	
	Dialogue = [Text, Text2, Text3, Text4, Text5, Text6, Text7, Text8, Text9]


# Check for intereactions
func _input(event) -> void :
	
	if event.is_action_pressed("ui_accept") and npc.intereactable :
		
		if Dialogue.size() > x :
			
			change_text()


# Update Text
func change_text() -> void :
	
	if Dialogue[x] != "" : # Check if dialogue finished
		
		$Label.text = Dialogue[x]
		print("Texted")
		x += 1
	
	else :
		
		if Globals.is_choice_being_made == false and not choice_made :
			
			Globals.is_choice_being_made = true
			
			make_choice()
			
			print("Nothing to see here...")


# Instantiate choice scene
func make_choice() -> void :
	
	Globals.choice_scene.emit()
	
	choice_made = true
