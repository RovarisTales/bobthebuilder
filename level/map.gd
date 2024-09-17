extends Node2D

@export var enemies_scene: PackedScene

var wave_number := 1.0
var time_to_survive: float
var spawn_rate := 1.5
var height := 0

func _ready() -> void:
	time_to_survive = 10
	hide()
	SignalBus.start_game.connect(start_game)
	SignalBus.start_wave.connect(start_wave)
	SignalBus.build_block.connect(move_up)


func start_game() -> void:
	show()

func _process(delta: float) -> void:
	$Label.text = str(int($WaveTimer.time_left))

func start_wave() -> void:
	$WaveTimer.start(wave_number*time_to_survive)
	$EnemyTimer.start(randf_range(0.1, 0.2))
	
	
func _on_enemy_timer_timeout() -> void:
	var enemy = enemies_scene.instantiate()
	
	var direction = -1 if randf() < 0.5 else 1
	
	enemy.speed = direction * 200
	
	enemy.position = Vector2i(0 if direction == 1 else 1920 ,50 - height)
	
	add_child(enemy)


func _on_wave_timer_timeout() -> void:
	$Label.text = ""
	$EnemyTimer.stop()
	SignalBus.end_wave.emit()
	time_to_survive *= 1.1
	print(time_to_survive)

func move_up() -> void:
	height += 46
