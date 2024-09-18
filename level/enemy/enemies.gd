extends Node2D

@export var attack_scene: PackedScene
var attack_speed:= 1
var health: int
var damage: int
var speed: float


func _ready() -> void:
	$AttackTimer.start(randf_range(attack_speed - 0.2, attack_speed + 0.2))
	SignalBus.end_wave.connect(end_wave)

func _process(delta: float) -> void:

	position.x += delta * speed



func _on_attack_timer_timeout() -> void:
	
	var projectile = attack_scene.instantiate()
	
	projectile.position = position
	
	get_parent().add_child(projectile)
	
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func end_wave() -> void:
	$AttackTimer.stop()
