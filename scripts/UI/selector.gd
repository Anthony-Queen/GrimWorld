extends ColorRect


@export var self_offset: Vector2

@onready var camera_3d: Camera3D = $"../../../../Camera3D"


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	
	self.position = (camera_3d.unproject_position(get_parent().get_parent().position) + self_offset)
