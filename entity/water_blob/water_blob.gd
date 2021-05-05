extends Node2D

export var speed: int = 50
onready var tween = $Tween
onready var start_pos = $StartPosition.global_position
onready var end_pos = $EndPosition.global_position
var dir = Dir.TO_START

enum Dir {
	TO_END,
	TO_START,
}

func _ready():
	$AnimationPlayer.stop(true)
	$AnimationPlayer.play("WaterWobble")
	_on_Tween_tween_all_completed()

func _on_Tween_tween_all_completed():
	if dir == Dir.TO_END:
		tween.interpolate_property(
			self,
			"global_position",
			global_position,
			start_pos,
			start_pos.distance_to(global_position) / speed,
			Tween.TRANS_SINE
		)
		dir = Dir.TO_START
	else:
		tween.interpolate_property(
			self,
			"global_position",
			global_position,
			end_pos,
			end_pos.distance_to(global_position) / speed,
			Tween.TRANS_SINE
		)
		dir = Dir.TO_END
	tween.start()
