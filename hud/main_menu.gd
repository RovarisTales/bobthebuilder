extends Control

func _ready() -> void:
	show()

func _on_button_pressed() -> void:
	hide()
	SignalBus.start_game.emit()
