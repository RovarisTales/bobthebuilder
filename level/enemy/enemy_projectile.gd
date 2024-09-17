extends Node2D

@export var damage := 5
var speed = 100
var accell = 5
var max_speed = 1000

func _process(delta: float) -> void:
	speed = max_speed if accell + speed > max_speed else accell + speed
	global_position += global_position.direction_to(Vector2(960,1100)) * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()


func _on_area_entered(area: Area2D) -> void:
	#print(area.get_groups())
	if area.get_parent().is_in_group("turret_attacks"):
		GlobalVars.coins += 5
		SignalBus.update_coins.emit()
		area.get_parent().queue_free()
		queue_free()
	elif area.is_in_group("projectiles") or area.is_in_group("exited"):
		pass
	else:
		GlobalVars.health -= damage
		SignalBus.take_damage.emit()
		queue_free()
