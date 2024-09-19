extends Node2D

@export var attacks: PackedScene
var attack_speed:= 1.0
var can_attack := true
var upgrade_price = 501


func _ready() -> void:
	SignalBus.start_wave.connect(start_wave)
	$CanvasLayer.offset = global_position
	
func start_wave() -> void:
	$Timer.start(attack_speed)

func _process(delta: float) -> void:
	
	if can_attack == false:
		pass
	elif get_tree().get_nodes_in_group("projectiles").size() > 0:
		attack()
	elif get_tree().get_nodes_in_group("exited").size() > 0:
		attack_exited()
	

func _on_timer_timeout() -> void:
	can_attack = true

func attack() -> void:
	can_attack = false
	var attack = attacks.instantiate()
	add_child(attack)
	$Timer.start(attack_speed)

func attack_exited() -> void:
	can_attack = false
	var attack = attacks.instantiate()
	attack.attack_exited = true
	add_child(attack)
	$Timer.start(attack_speed)

func _on_button_pressed() -> void:
	if GlobalVars.coins < upgrade_price:
		SignalBus.cannot_buy.emit()
	else:
		GlobalVars.coins -= upgrade_price
		SignalBus.update_coins.emit()
		attack_speed /= 2
		print(attack_speed)
