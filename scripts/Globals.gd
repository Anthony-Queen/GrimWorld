extends Node

@onready var character_node : Sprite3D

var audio_stream_player: AudioStreamPlayer
@warning_ignore_start("unused_signal")

# Dialogue signals
signal choice1
signal choice2
signal choiceScene

# Combat signals
signal entered_battle
signal turn_changed


@warning_ignore_restore("unused_signal")

var isChoiceBeingMade: bool = false
var InBattle : bool = false
var turn : int = 0

func _ready() -> void:
	
	self.connect("turn_changed", _on_turn_changed)

func _on_turn_changed() :
	
	turn += 1
