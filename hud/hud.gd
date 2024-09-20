extends CanvasLayer

func _ready() -> void:
	SignalBus.win_game.connect(win_game)
	SignalBus.game_over.connect(game_over)
	
func game_over() -> void:
	$GameHud.hide()
	$Lose.show()
	
func win_game() -> void:
	$GameHud.hide()
	$Win.show()
