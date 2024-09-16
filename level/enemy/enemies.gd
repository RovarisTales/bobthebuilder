extends Node2D

@export var attack_scene: PackedScene
var attack_speed: float
var health: int
var damage: int
var speed: float = 200


func _ready() -> void:
	$AttackTimer.start()

func _process(delta: float) -> void:

	position.x += delta * speed



func _on_attack_timer_timeout() -> void:
	var projectile = attack_scene.instantiate()
	
	add_child(projectile)
	$AttackTimer.wait_time = randf_range(1,2)
	


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
