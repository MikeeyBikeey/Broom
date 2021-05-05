extends KinematicBody2D

const Spell = preload("res://entity/player/spell/spell.gd")
const DeadVillager = preload("res://entity/villager/dead_villager/dead_villager.tscn")

var alive: bool = true
#onready var dead_body = DeadVillager.instance()

func _on_HurtBox_attacked(attacker):
	call_deferred("die", attacker)

func die(attacker):
	if alive && attacker is Spell:
		alive = false
		var dead_body = DeadVillager.instance()
		get_parent().add_child(dead_body)
		dead_body.global_position = global_position
		dead_body.apply_central_impulse(Vector2(rand_range(-50, 50), -100))
		dead_body.add_torque(rand_range(-300, 300))
		queue_free()
