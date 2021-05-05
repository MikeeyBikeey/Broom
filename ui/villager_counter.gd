extends Control

var villagers_max := 0 setget set_villagers_max
var villagers_cursed := 0 setget set_villagers_cursed

func set_villagers_max(value: int):
	villagers_max = value
	__update_counter()

func set_villagers_cursed(value: int):
	villagers_cursed = value
	__update_counter()

func __update_counter():
	$HBoxContainer/Label.text = String(villagers_cursed) + "/" + String(villagers_max)
