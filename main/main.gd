extends Node

var levels := [
	preload("res://level/level1.tscn"),
	preload("res://level/level2.tscn"),
	preload("res://level/level4.tscn"),
	preload("res://level/level3.tscn"),
	preload("res://level/credits.tscn"),
#	preload("res://level/playground.tscn"),
]
var cur_level := 0

func _ready():
	randomize()
	restart_level()

func _input(event):
	if event.is_action_pressed("toggle_fullscreen"):
		OS.window_fullscreen = !OS.window_fullscreen

func goto_next_level():
	cur_level = (cur_level + 1) % levels.size()
	remove_children($World)
	$World.add_child(levels[cur_level].instance())

func restart_level():
	remove_children($World)
	$World.add_child(levels[cur_level].instance())

static func remove_children(node: Node):
	for n in node.get_children():
		node.remove_child(n)
		n.queue_free()
