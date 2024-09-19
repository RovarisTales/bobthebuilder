extends HBoxContainer

func _ready() -> void:
	hide()
	SignalBus.build_weapon.connect(show_hud)
	
func show_hud() -> void:
	show()
