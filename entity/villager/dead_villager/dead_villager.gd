extends RigidBody2D

func _ready():
	$Sprite.frame = randi()%$Sprite.hframes
