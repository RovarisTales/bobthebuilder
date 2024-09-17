extends Node2D

@export var attacks: PackedScene
var attack_speed:= 1.0
var can_attack := true
var wave_ended := false


func _ready() -> void:
	SignalBus.start_wave.connect(start_wave)
	SignalBus.end_wave.connect(end_wave)
	
func start_wave() -> void:
	$Timer.start(attack_speed)
	wave_ended = false

func _process(delta: float) -> void:
	
	if can_attack == false:
		pass
	elif get_tree().get_nodes_in_group("projectiles").size() > 0:
		attack()
	elif wave_ended:
		$Timer.stop()

func _on_timer_timeout() -> void:
	can_attack = true

func attack() -> void:
	can_attack = false
	var attack = attacks.instantiate()
	add_child(attack)
	$Timer.start(attack_speed)

func end_wave() -> void:
	wave_ended = true
