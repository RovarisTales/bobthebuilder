extends Node2D

@export var enemies_scene: PackedScene

const DECAY_RATE := 3.0

var wave_number := 1.0
var time_to_survive: float
var spawn_rate :float
@onready var attack_speed := 2
var height := 0
var diff = 0.25

func _ready() -> void:
	time_to_survive = 10
	hide()
	SignalBus.start_game.connect(start_game)
	SignalBus.start_wave.connect(start_wave)
	SignalBus.build_block.connect(move_up)
	spawn_rate = pow(DECAY_RATE, (-wave_number + 8)/7 )


func start_game() -> void:
	show()

func _process(delta: float) -> void:
	$WaveTimeLabel.text = str(int($WaveTimer.time_left))

func start_wave() -> void:
	$WaveTimer.start(time_to_survive)
	$EnemyTimer.start(spawn_rate)
	_on_enemy_timer_timeout()
	

func _on_enemy_timer_timeout() -> void:
	
	var enemy = enemies_scene.instantiate()
	var direction = -1 if randf() < 0.5 else 1
	enemy.speed = direction * randf_range(180,220)
	enemy.attack_speed = attack_speed
	enemy.position = Vector2i(0 if direction == 1 else 1920 ,50 - height + randf_range(-30, 40))
	
	add_child(enemy)


func _on_wave_timer_timeout() -> void:
	wave_number += 1
	$WaveTimeLabel.text = ""
	$EnemyTimer.stop()
	SignalBus.end_wave.emit()
	time_to_survive *= 1.1
	attack_speed /= 1.1
	spawn_rate = pow(DECAY_RATE, (-wave_number + 8)/7 )
	
func move_up() -> void:

	height += 46
