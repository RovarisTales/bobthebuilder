extends Label

func _ready() -> void:
	SignalBus.build_block.connect(move)
	
func move() -> void:
	position -= Vector2(0,46)
