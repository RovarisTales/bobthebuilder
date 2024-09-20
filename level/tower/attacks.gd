extends Node2D

var target_loc
var target
var direction_vector
var attack_exited = false
var multipliyer

var speed: float

func _ready() -> void:
	if !attack_exited:
		select_target()
	else:
		select_exited()
	

func _process(delta: float) -> void:
	if target != null:
		target_loc = target.global_position
		direction_vector = global_position.direction_to(target_loc)
	else:
		queue_free()
	global_position += direction_vector * speed * delta

func select_target() -> void:
	target = get_tree().get_nodes_in_group("projectiles").pop_front()
	if target != null:
		target.remove_from_group("projectiles")
		target.add_to_group("exited")
		target_loc = target.global_position
		direction_vector = global_position.direction_to(target_loc)
	else :
		queue_free()
		
func select_exited() -> void:
	target = get_tree().get_nodes_in_group("exited").pop_front()
	if target != null:
		target_loc = target.global_position
		direction_vector = global_position.direction_to(target_loc)
	else :
		queue_free()
