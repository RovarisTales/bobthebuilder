extends Node2D

@export var enemies_scene: PackedScene

var wave_number = 1

func _ready() -> void:
	hide()
	SignalBus.start_game.connect(start_game)
	SignalBus.start_wave.connect(start_wave)

func start_game() -> void:
	show()

func start_wave() -> void:
	$WaveTimer.start()


func _on_wave_timer_timeout() -> void:
	var enemy = enemies_scene.instantiate()
	
	var direction = -1 if randf() < 0.5 else 1
	
	enemy.speed = direction * 200
	
	enemy.position = Vector2i(0 if direction == 1 else 1920 ,50)
	
	add_child(enemy)
