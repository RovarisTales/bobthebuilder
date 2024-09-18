extends TextureRect

@onready var turrets := 0
var test

func _ready() -> void:
	SignalBus.build_weapon.connect(upgrade)

func upgrade():
	turrets += 1
	if turrets >= GlobalVars.MAX_TURRETS:
		SignalBus.build_weapon.disconnect(upgrade)
		get_parent().get_node("AspectRatioContainer/DamageButton").theme = null
