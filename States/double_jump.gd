extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	if previous_state_path == GLIDING:
		player.velocity.y = -player.glide_jump_impulse
	else:
		player.velocity.y = -player.jump_impulse
	
	#Animation Call
	$"../../AnimatedSprite2D".play("doublejump")
	$"../../AnimationPlayer_jumpsfx".play("jump_sfx")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x

	player.velocity.y += player.gravity /1.1 * delta   #DblJump Boost Default 1.1

	player.move_and_slide()

	if Input.is_action_just_pressed("glide"):
		finished.emit(GLIDING)
	elif player.velocity.y >= 0:
		finished.emit(FALLINGDBLJUMP)
	elif player.is_on_wall():
		finished.emit(WALLSLIDE)
