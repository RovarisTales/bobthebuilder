extends Control

func _ready() -> void:
	hide()
	SignalBus.start_game.connect(start_game)

func start_game() -> void:
	show()
