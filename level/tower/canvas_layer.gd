extends CanvasLayer

func _ready() -> void:
	SignalBus.build_block.connect(move)

func move() -> void:
	offset += Vector2(0,-64)
