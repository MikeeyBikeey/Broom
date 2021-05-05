extends Control

func _process(delta):
	if Input.is_action_just_pressed("menu_toggle_menu"):
		toggle_pause()
	
	if visible:
		if Input.is_action_just_pressed("menu_skip_level"):
			get_node("/root/Main").call_deferred("goto_next_level")
			toggle_pause()
		if Input.is_action_just_pressed("menu_redo_level"):
			get_node("/root/Main").call_deferred("restart_level")
			toggle_pause()
		if Input.is_action_just_pressed("menu_quit"):
			get_tree().quit()

func toggle_pause():
	visible = !visible
	get_tree().paused = visible
