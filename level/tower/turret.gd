extends Node2D

@export var attacks: PackedScene
var attack_speed:= 1.0
var can_attack := true
var velocity_price := 2
var attack_speed_price := 10
var bullet_velocity := 1000.0
var wave_ended = false
var upgrade_count := 0
var gold_multipliyer_cost = 10
var multipliyer = 1

func _ready() -> void:
	SignalBus.start_wave.connect(start_wave)
	SignalBus.end_wave.connect(func():
		wave_ended = true)
	$CanvasLayer.offset = global_position
	$CanvasLayer/AttackSpeedUpgrade.tooltip_text = str(attack_speed_price)
	$CanvasLayer/VelocityUpgrade.tooltip_text = str(velocity_price)
	$CanvasLayer/MultipliyerUpgrade.tooltip_text = str(gold_multipliyer_cost)
	
func start_wave() -> void:
	wave_ended = false
	$Timer.start(attack_speed)

func _process(delta: float) -> void:
	
	if can_attack == false:
		pass
	elif get_tree().get_nodes_in_group("projectiles").size() > 0:
		attack()
	elif get_tree().get_nodes_in_group("exited").size() > 0 and wave_ended:
		attack_exited()
	

func _on_timer_timeout() -> void:
	can_attack = true

func attack() -> void:
	can_attack = false
	var attack = attacks.instantiate()
	attack.speed = bullet_velocity
	attack.multipliyer = multipliyer
	add_child(attack)
	$Timer.start(attack_speed)

func attack_exited() -> void:
	can_attack = false
	var attack = attacks.instantiate()
	attack.attack_exited = true
	add_child(attack)
	$Timer.start(attack_speed)



func _on_attack_speed_upgrade_pressed() -> void:
	if GlobalVars.coins < attack_speed_price:
		SignalBus.cannot_buy.emit()
	else:
		GlobalVars.coins -= attack_speed_price
		SignalBus.update_coins.emit()
		attack_speed /= 1.4
		attack_speed_price *= 3
		$CanvasLayer/AttackSpeedUpgrade.tooltip_text = str(attack_speed_price)
		


func _on_velocity_upgrade_pressed() -> void:
	if GlobalVars.coins < velocity_price:
		SignalBus.cannot_buy.emit()
	else:
		GlobalVars.coins -= velocity_price
		SignalBus.update_coins.emit()
		bullet_velocity *= 1.2
		velocity_price *= 5
		upgrade_count += 1
		$CanvasLayer/VelocityUpgrade.tooltip_text = str(velocity_price)
		if upgrade_count > 5:
			$CanvasLayer/VelocityUpgrade.hide()


func _on_multipliyer_upgrade_pressed() -> void:
	if GlobalVars.coins < gold_multipliyer_cost:
		SignalBus.cannot_buy.emit()
	else:
		GlobalVars.coins -= gold_multipliyer_cost
		gold_multipliyer_cost *= 10
		SignalBus.update_coins.emit()
		multipliyer *= 1.5
		$CanvasLayer/MultipliyerUpgrade.tooltip_text = str(gold_multipliyer_cost)
