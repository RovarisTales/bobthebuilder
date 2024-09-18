extends Node2D

@export var turrets: PackedScene
var turret_list = []
var turret_count := 0
const turret_positions := [Vector2(0,-48),Vector2(-100,-48),Vector2(100,-48),Vector2(-200,-48), Vector2(200,-48),Vector2(-300,-48), Vector2(300,-48)]
var turret_to_upgrade := 0
var height = 0

func _ready() -> void:
	SignalBus.build_block.connect(build_block)
	SignalBus.build_weapon.connect(build_weapon)

func build_block() -> void :
	height += 1
	
	$Area2D/CollisionShape2D.translate(Vector2(0,-32))
	$Area2D/CollisionShape2D.shape.size.y += 64
	for turret in get_tree().get_nodes_in_group("turrets"):
		turret.translate(Vector2(0,-64))
	GlobalVars.health += 100 * pow(height,1.3)
	
	
func build_weapon() -> void :
	if turret_count >= GlobalVars.MAX_TURRETS:
		upgrade_turret(turret_list[turret_to_upgrade])
		turret_to_upgrade = 0 if turret_to_upgrade >= GlobalVars.MAX_TURRETS- 1 else turret_to_upgrade + 1
	else:
		var turret = turrets.instantiate()
		turret.translate(turret_positions[turret_count])
		add_child(turret)
		turret_list.append(turret)
		turret_count += 1

func upgrade_turret(turret) -> void:
	print(turret.attack_speed )
	turret.attack_speed  =  turret.attack_speed / 2.0
	print(turret.attack_speed )
