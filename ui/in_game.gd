extends Control

#const Player := preload("res://entity/player/player.gd")

#var player: Player setget set_player

#func _ready():
#	set_player(get_tree().get_nodes_in_group("Player")[0])

#func set_player(value: Player):
#	player = value
#	player.connect("num_boosts_changed", self, "on_player_num_boosts_changed")
#	player.connect("health_changed", self, "on_player_health_changed")

func _physics_process(delta):
	update_villager_stats()
	update_player_state()

func update_player_state():
	var player = get_tree().get_nodes_in_group("Player").front()
	if player != null:
		$MarginContainer/Control/BoostCounter.num_boosts = player.num_boosts
		$MarginContainer/Control/HealthCounter.health = player.health

func update_villager_stats():
	var level = get_tree().get_nodes_in_group("Level").front()
	if level != null:
		var num_villagers = get_tree().get_nodes_in_group("Cursable").size()
		$MarginContainer/Control/VillagerCounter.villagers_max = level.num_villagers
		$MarginContainer/Control/VillagerCounter.villagers_cursed = level.num_villagers - num_villagers

#func on_player_num_boosts_changed(num_boosts: int):
#	$MarginContainer/Control/BoostCounter.num_boosts = num_boosts
#
#func on_player_health_changed(health: int):
#	$MarginContainer/Control/HealthCounter.health = health
