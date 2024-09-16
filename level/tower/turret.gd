extends Node2D

@export var attacks: PackedScene
var attack_speed: float

func _ready() -> void:
	SignalBus.start_wave.connect(start_wave)
	
func start_wave() -> void:
	$Timer.start(attack_speed)


func _on_timer_timeout() -> void:
	var attack = attacks.instantiate()
	add_child(attack)
