extends KinematicBody2D

const Spell := preload("res://entity/player/spell/spell.tscn")

export var turn_speed: float = 400
export var max_momentum: float = 200
export var boost_speed: float = 250
export var acceleration: float = 100
export var invincible: bool = false # for use with the animation
export var max_boosts: int = 3
export var max_health: int = 3
export var shoot_reach: float = 192
var momentum := 0.0
var velocity := Vector2.ZERO
var num_boosts := max_boosts setget set_num_boosts
var health := max_health setget set_health

signal num_boosts_changed(num_boosts)
signal health_changed(health)

func set_num_boosts(value: int):
	num_boosts = clamp(value, 0, max_boosts)
	emit_signal("num_boosts_changed", num_boosts)

func set_health(value: int):
	health = clamp(value, 0, max_health)
	emit_signal("health_changed", health)
	if health <= 0:
		game_over()

func _physics_process(delta):
	# ((max_momentum - abs(momentum) / 2) / max_momentum)
	if Input.is_action_pressed("left"):
#		global_rotation_degrees -= turn_speed * delta
		global_rotation_degrees -= turn_speed * ((max_momentum - abs(momentum) * 0.35) / max_momentum) * delta
	if Input.is_action_pressed("right"):
#		global_rotation_degrees += turn_speed * delta
		global_rotation_degrees += turn_speed * ((max_momentum - abs(momentum) * 0.35) / max_momentum) * delta
	
	update_sprite_flip()
	update_momentum(delta)
#	velocity = velocity.move_toward(Vector2(cos(global_rotation), sin(global_rotation)) * momentum, acceleration * delta)
	velocity = Vector2(cos(global_rotation), sin(global_rotation)) * momentum
	move_and_slide(velocity)

func _unhandled_input(event):
	if event.is_action_pressed("boost"):
		boost()

func boost():
	if num_boosts > 0:
		set_num_boosts(num_boosts - 1)
		momentum = boost_speed
		$BoostTimer.start()

func hurt():
	if !invincible:
		set_health(health - 1)
		$HurtSound.play()
		$HurtAnimationPlayer.play("Invincible")

func shoot_nearby_cursables():
	var cursables := get_tree().get_nodes_in_group("Cursable")
	for c in cursables:
		$RayCast2D.cast_to = (c.global_position - global_position).rotated(-rotation)
		$RayCast2D.force_raycast_update()
		if !$RayCast2D.is_colliding() && global_position.distance_to(c.global_position) < shoot_reach:
			shoot_spell(global_position.direction_to(c.global_position))

func shoot_spell(dir: Vector2):
	var spell = Spell.instance()
	get_parent().add_child(spell)
	spell.global_position = global_position
	spell.direction = dir

func update_momentum(delta):
	momentum = move_toward(momentum, sign(global_rotation) * max_momentum, acceleration * delta)

func update_sprite_flip():
	$Sprite.flip_v = !(global_rotation > -0.5 * PI && global_rotation < 0.5 * PI)

func game_over():
	get_node("/root/Main").call_deferred("restart_level")

func _on_BoostTimer_timeout():
	set_num_boosts(max_boosts)
	$AudioStreamPlayer2D.play()

func _on_HurtByFloorBox_body_entered(body):
	hurt()

func _on_HurtBox_attacked(attacker):
	if attacker is Node && attacker.is_in_group("Enemy"):
		hurt()

func _on_ShootTimer_timeout():
	shoot_nearby_cursables()
#	shoot_spell(Vector2.RIGHT.rotated(rand_range(-PI, PI))) # :'> hehe

func _on_LevelExitArea_area_entered(area):
	get_node("/root/Main").call_deferred("goto_next_level")
