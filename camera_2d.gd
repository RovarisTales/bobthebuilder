extends Camera2D

func _ready() -> void:
	SignalBus.build_block.connect(move_camera)
	
	
func move_camera():
	position.y -= 46
