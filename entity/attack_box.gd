extends Area2D

export var entity_path: NodePath
onready var entity: Node = get_node(entity_path)

signal attacked(attacked)
