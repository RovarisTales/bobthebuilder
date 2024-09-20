extends Node2D

@export var damage := 5
var speed = 100
var accell = 5
var max_speed = 750
var target

func _ready() -> void:
	target = Vector2(randf_range(650,1250),GlobalVars.current_height.y * 16 + 50) 

func _process(delta: float) -> void:
	speed = max_speed if accell + speed > max_speed else accell + speed
	global_position += global_position.direction_to(target) * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("turret_attacks"):
		GlobalVars.coins += 5 * area.get_parent().multipliyer
		SignalBus.update_coins.emit()
		area.get_parent().queue_free()
		queue_free()
	else:
		GlobalVars.health -= damage
		SignalBus.take_damage.emit()
		queue_free()
