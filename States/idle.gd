extends PlayerState


func enter(previous_state_path: String, data := {}) -> void:
	player.velocity.x = 0.0
	
	#Animation Call
	$"../../AnimatedSprite2D".play("idle")

func physics_update(_delta: float) -> void:
	player.velocity.y += player.gravity * _delta
	player.move_and_slide()


	if not player.is_on_floor():
		finished.emit(FALLING)
	elif Input.is_action_pressed("move_down"):
		finished.emit(CROUCHING)
	elif Input.is_action_just_pressed("move_up"):
		finished.emit(JUMPING)
		jump_count += 1
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		finished.emit(RUNNING)
