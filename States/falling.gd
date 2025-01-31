extends PlayerState
#Double Jump Limits


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	
	player.move_and_slide()
	
	if player.is_on_floor():
		jump_count = 0
	if Input.is_action_just_pressed("glide"):
		finished.emit(GLIDING)
	elif player.is_on_floor():
		if is_equal_approx(player.velocity.x, 0.0):
			finished.emit(IDLE)
		else:
			finished.emit(RUNNING)
	elif Input.is_action_just_pressed("move_up") and jump_count < max_jumps:
		jump_count += 1
		finished.emit(COYOTEJUMP)
	elif player.is_on_wall():
		finished.emit(WALLSLIDE)
