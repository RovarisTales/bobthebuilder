extends Node2D

var target_loc
var target

var speed = 10000

func _ready() -> void:
	target = get_tree().get_nodes_in_group("projectiles").pop_front()
	if target != null:
		target.remove_from_group("projectiles")
		target_loc = target.global_position
	else :
		queue_free()
	

func _process(delta: float) -> void:
	target_loc = target.global_position
	global_position += global_position.direction_to(target_loc) * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	queue_free()
