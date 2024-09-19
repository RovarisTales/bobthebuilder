extends TileMapLayer



func _ready() -> void:
	SignalBus.build_block.connect(build)
	build()
	
func build() -> void:
	for i in range(4):
		for j in range(45):
			set_cell(GlobalVars.current_height + Vector2i(j,-i), 0, Vector2i(0,0), 0)
	GlobalVars.current_height.y -= 4
	if GlobalVars.current_height.y < -30:
		SignalBus.win_game.emit()
		
