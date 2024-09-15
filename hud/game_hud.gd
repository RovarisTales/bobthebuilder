extends Control

var block_price = 5
var attack_price = 1

func _ready() -> void:
	hide()
	SignalBus.start_game.connect(start_game)
	SignalBus.update_coins.connect(update_coin_hud)
	$BlockUpgradeContainer/PriceBlock.text = str(block_price)
	$DamageUpgradeContainer/PriceAttack.text = str(attack_price)
	$CoinsContainer/CoinLabel.text = str(GlobalVars.coins)

func start_game() -> void:
	show()


func _on_build_button_pressed() -> void:
	if GlobalVars.coins < block_price:
		print("you cant buy this you dummy")
	else:
		GlobalVars.coins -= block_price
		SignalBus.update_coins.emit()

func update_coin_hud() -> void:
	$CoinsContainer/CoinLabel.text = str(GlobalVars.coins)


func _on_start_wave_button_pressed() -> void:
	SignalBus.start_wave.emit()
