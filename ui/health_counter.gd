extends Control

var health := 3 setget set_health

func set_health(value: int):
	health = value
	$TextureRect.rect_size.x = health * $TextureRect.texture.get_width()
