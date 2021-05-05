extends Node2D

const SpellExplosion := preload("res://entity/player/spell_explosion/spell_explosion.tscn")

export var speed: int = 200
var direction: Vector2 = Vector2.ZERO

func _physics_process(delta):
	global_position += direction * speed * delta

func explode():
	var explosion := SpellExplosion.instance()
	get_parent().add_child(explosion)
	explosion.global_position = global_position
	explosion.apply_central_impulse(Vector2.RIGHT.rotated(-global_rotation) * speed)
	queue_free()

func _on_AttackBox_attacked(attacked: Node2D):
	if attacked is Node2D && attacked.is_in_group("Cursable"):
		call_deferred("explode")

func _on_Area2D_body_entered(body):
	call_deferred("explode")
