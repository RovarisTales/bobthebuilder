extends Control

var block_price = 50
var attack_price = 5
var height := 0

func _ready() -> void:
	hide()
	SignalBus.start_game.connect(start_game)
	SignalBus.update_coins.connect(update_coin_hud)
	SignalBus.take_damage.connect(update_health)
	SignalBus.cannot_buy.connect(display_warning)
	$BlockUpgradeContainer/PriceBlock.text = str(block_price)
	$CreateTurret/PriceAttack.text = str(attack_price)
	$CoinsContainer/CoinLabel.text = format_custom(GlobalVars.coins)
	$HealthContainer/HealthLabel.text = str(GlobalVars.health)

func start_game() -> void:
	show()


func _on_build_button_pressed() -> void:
	if GlobalVars.coins < block_price:
		SignalBus.cannot_buy.emit()
	else:
		height += 1
		GlobalVars.coins -= block_price
		SignalBus.build_block.emit()
		SignalBus.update_coins.emit()
		block_price *= 10
		$BlockUpgradeContainer/PriceBlock.text = str(block_price)
		GlobalVars.health += 100 * pow(height,1.3)
		update_health()

func update_coin_hud() -> void:
	$CoinsContainer/CoinLabel.text = format_custom(GlobalVars.coins)


func _on_start_wave_button_pressed() -> void:
	SignalBus.start_wave.emit()


func _on_damage_button_pressed() -> void:
	if GlobalVars.coins < attack_price:
		SignalBus.cannot_buy.emit()
	else:
		GlobalVars.coins -= attack_price
		SignalBus.build_weapon.emit()
		SignalBus.update_coins.emit()
		attack_price *= 5
		$CreateTurret/PriceAttack.text = str(attack_price)

func update_health() -> void :
	$HealthContainer/HealthLabel.text = str(GlobalVars.health)


func display_warning() -> void:
	var label = Label.new()
	label.label_settings = load("res://assets/hud.tres")
	label.text ="CANT BUY THIS!!!!!"
	label.global_position = Vector2(680, 400)
	label.z_index = 100
	add_child(label)
	var tween_label = get_tree().create_tween()
	tween_label.tween_property(label, "modulate", Color.TRANSPARENT, 2.0)
	await tween_label.finished
	label.queue_free()

func format_custom(formater) -> String:
	var iterator = float(formater)
	var count = 0
	while iterator > 1000:
		iterator /= 1000
		count += 1
	if count > 0:
		return "%7.2f %s" % [iterator, String.chr(64 + count)]
	return str(formater)
