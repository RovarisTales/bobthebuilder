extends Node2D

var health: int
@export var turrets: PackedScene

func _ready() -> void:
	SignalBus.build_block.connect(build_block)
	SignalBus.build_weapon.connect(build_weapon)

func build_block() -> void :
	health += 10
	$Area2D/CollisionShape2D.translate(Vector2(0,-64))
	
	
func build_weapon() -> void :
	var turret = turrets.instantiate()
	add_child(turret)

func _on_area_2d_area_entered(area: Area2D) -> void:
	GlobalVars.health -= area.damage
	SignalBus.take_damage.emit()
	area.queue_free()
