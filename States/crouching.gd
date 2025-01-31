extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
		#Animation Cal
	$"../../AnimatedSprite2D".play("crouch")

func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y += player.gravity * delta
	player.move_and_slide()


	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_pressed("move_down") and Input.get_axis("move_left", "move_right"):
		finished.emit(CRAWLING)
	elif Input.is_action_pressed("move_down"):
		finished.emit(CROUCHING)
	elif Input.is_action_just_pressed("move_up"):
		finished.emit(JUMPING)
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		finished.emit(RUNNING)
	elif is_equal_approx(input_direction_x, 0.0):
		finished.emit(IDLE)
