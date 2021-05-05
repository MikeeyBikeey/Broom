extends RigidBody2D

func _on_AliveTime_timeout():
	queue_free()
