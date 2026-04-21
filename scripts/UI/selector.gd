extends ColorRect


@export var self_offset: Vector2

@onready var camera_3d: Camera3D = $"../../../../Camera3D"

var enemy : Enemy

func _ready() -> void :
	
	enemy = get_parent().get_parent()
	
	self.position = (camera_3d.unproject_position(enemy.position) + self_offset)
	
	self.position.y += (camera_3d.position.z - enemy.position.z) * 10
