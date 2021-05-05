extends Area2D

const AttackBox = preload("attack_box.gd")

export var entity_path: NodePath
onready var entity: Node = get_node(entity_path)

signal attacked(attacker)

func _on_HurtBox_area_entered(area: AttackBox):
	if area is AttackBox:
		emit_signal("attacked", area.entity)
		area.emit_signal("attacked", entity)
