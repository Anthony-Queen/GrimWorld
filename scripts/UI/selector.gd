extends Sprite2D


@export var self_offset: Vector2

@onready var camera_3d: Camera3D = $"../../../../Camera3D"

var enemy : Enemy

func _ready() -> void :
	
	enemy = get_parent().get_parent()
	
	get_parent().position = (camera_3d.unproject_position(enemy.position) + self_offset)
	
	self.position.y -= (enemy.position.z * 50)
	self.position.x += (enemy.position.z * 20)
