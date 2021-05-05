extends KinematicBody2D

export var max_speed: float = 100
export var acceleration: float = 200
export var friction: float = 10
var target: Node2D = null
var moving_toward := Vector2.ZERO
var velocity := Vector2.ZERO

func _physics_process(delta):
	if target != null:
		chase_target(delta)
	move(delta)

func chase_target(delta):
	if can_see(target.global_position):
		moving_toward = global_position.direction_to(target.global_position)
		global_rotation = global_position.direction_to(target.global_position).angle()
	else:
		target = null

func move(delta):
	if moving_toward != Vector2.ZERO:
		velocity = velocity.move_toward(moving_toward * max_speed, acceleration * delta)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)
		
	if velocity != Vector2.ZERO:
		global_rotation = velocity.angle()
	
	velocity = move_and_slide(velocity)

func search_for_target():
	var players := get_tree().get_nodes_in_group("Player")
	for p in players:
		if can_see(p.global_position):
			target = p
			break

func can_see(pos: Vector2) -> bool:
	$RayCast2D.cast_to = (pos - global_position).rotated(-rotation)
	$RayCast2D.force_raycast_update()
	return !$RayCast2D.is_colliding()

func _on_SearchTimer_timeout():
	if target == null:
		search_for_target()
