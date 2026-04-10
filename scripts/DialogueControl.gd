extends Control

@export var target: Node3D
@export var offset_3d: Vector3


func _ready() -> void:
	var pos_3d := target.position + offset_3d
	position = pos_3d
