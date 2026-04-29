extends Sprite2D


@export var self_offset : Vector2 # Offset

@onready var camera_3d: Camera3D = $"../../../../Camera3D" # Camera (to unproject enemy postion)

var enemy : Enemy # Enemy node

# Change position
func _ready() -> void :
	
	enemy = get_parent().get_parent()
	
	get_parent().position = (camera_3d.unproject_position(enemy.position) + self_offset)
	
	self.position.y -= (enemy.position.z * 50)
	self.position.x += (enemy.position.z * 20)
