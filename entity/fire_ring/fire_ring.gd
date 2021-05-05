extends Node2D

const FireBall := preload("res://entity/fire_ring/fire_ball.tscn")

export var turn_time: float = 5
export var num_fire_balls: int = 5
export var fire_ball_seperation: float = 8

func _ready():
	for i in range(num_fire_balls):
		var fire = FireBall.instance()
		add_child(fire)
		fire.position.x = (i + 1) * fire_ball_seperation
	_on_Tween_tween_all_completed()

func _on_Tween_tween_all_completed():
	$Tween.interpolate_property(self, "rotation", -PI, PI, turn_time)
	$Tween.start()
