extends Node2D

export var follows_path: NodePath
export var record_size: int = 60
var positions := [] # Recorded positions of `follows`
onready var follows: Node2D = get_node(follows_path)

func _ready():
	positions.resize(record_size)
	for i in range(positions.size()):
		positions[i] = PosState.from_node2d(follows)

func _physics_process(delta):
	if follows is Node2D:
		positions.back().load_state(self)
		positions.pop_back()
		positions.push_front(PosState.from_node2d(follows))

class PosState extends Reference:
	var position := Vector2.ZERO
	var rotation := 0.0
	
	func _init(pos: Vector2 = Vector2.ZERO, rot: float = 0.0):
		position = pos
		rotation = rot
	
	func load_state(node: Node2D):
		node.global_position = position
		node.global_rotation = rotation
	
	static func from_node2d(node: Node2D):
		return PosState.new(node.global_position, node.global_rotation)

func _on_HarmlessTimer_timeout():
	$AttackBox/CollisionShape2D.disabled = false
	$Sprite.modulate = Color.white
