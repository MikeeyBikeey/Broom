extends Control

var num_boosts := 3 setget set_num_boosts

func set_num_boosts(value: int):
	num_boosts = value
	$TextureRect.rect_size.x = num_boosts * $TextureRect.texture.get_width()
