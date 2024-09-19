extends Control

var block_price = 5
var attack_price = 1
var upgrade_price = 1

func _ready() -> void:
	hide()
	SignalBus.start_game.connect(start_game)
	SignalBus.update_coins.connect(update_coin_hud)
	SignalBus.take_damage.connect(update_health)
	SignalBus.cannot_buy.connect(display_warning)
	$BlockUpgradeContainer/PriceBlock.text = str(block_price)
	$CreateTurret/PriceAttack.text = str(attack_price)
	$CoinsContainer/CoinLabel.text = str(GlobalVars.coins)
	$HealthContainer/HealthLabel.text = str(GlobalVars.health)

func start_game() -> void:
	show()


func _on_build_button_pressed() -> void:
	if GlobalVars.coins < block_price:
		print("you cant buy this you dummy")
	else:
		GlobalVars.coins -= block_price
		SignalBus.build_block.emit()
		SignalBus.update_coins.emit()

func update_coin_hud() -> void:
	$CoinsContainer/CoinLabel.text = str(GlobalVars.coins)


func _on_start_wave_button_pressed() -> void:
	SignalBus.start_wave.emit()


func _on_damage_button_pressed() -> void:
	if GlobalVars.coins < attack_price:
		print("you cant buy this you dummy")
	else:
		GlobalVars.coins -= attack_price
		SignalBus.build_weapon.emit()
		SignalBus.update_coins.emit()

func update_health() -> void :
	$HealthContainer/HealthLabel.text = str(GlobalVars.health)


func _on_upgrade_turret_button_pressed() -> void:
	if GlobalVars.coins < upgrade_price:
		print("you cant buy this you dummy")
	else:
		GlobalVars.coins -= upgrade_price
		SignalBus.upgrade_turret.emit()
		SignalBus.update_coins.emit()

func display_warning() -> void:
	var label = Label.new()
	label.label_settings = load("res://assets/hud.tres")
	label.text ="CANT BUY THIS!!!!!"
	label.global_position = Vector2(900, 500)
	label.z_index = 100
	add_child(label)
	get_tree().create_tween().tween_property(label, "modulate", Color.TRANSPARENT, 2.0)
