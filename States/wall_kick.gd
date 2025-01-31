extends PlayerState

func enter(previous_state_path: String, data := {}) -> void:
	if previous_state_path == WALLSLIDE:
		player.velocity.y = -player.wallkick_jump_impulse

func enter2(previous_state_path: String, data := {}) -> void:
	if previous_state_path == FALLING:
		player.velocity.y = -player.wallkick_jump_impulse




func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta

	#Animation Call
	$"../../AnimatedSprite2D".play("wallkick")
	player.move_and_slide()


	if player.is_on_wall() and Input.is_action_just_pressed("wallkick"):
		finished.emit(WALLSLIDE)
	elif player.velocity.y >= 0:
		finished.emit(FALLING)
#	elif Input.is_action_just_pressed("double_jump"):
#		finished.emit(DOUBLEJUMP)
	elif Input.is_action_just_pressed("glide"):
		finished.emit(GLIDING)
