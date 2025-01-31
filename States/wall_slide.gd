extends PlayerState


func physics_update(delta: float) -> void:
	var input_direction_x := Input.get_axis("move_left", "move_right")
	player.velocity.x = player.speed * input_direction_x
	player.velocity.y = player.wallslide_gravity * delta

	player.move_and_slide()
	#Animation Call
	$"../../AnimatedSprite2D".play("wallslide")



	if Input.is_action_just_pressed("wallkick"):
		finished.emit(WALLKICK)
		$"../../AnimationPlayer_jumpsfx".play("jump_sfx")
	elif Input.is_action_just_pressed("glide"):
		finished.emit(GLIDING)
	elif not player.is_on_wall():
		finished.emit(FALLING)
	elif Input.is_action_pressed("move_down"):
		finished.emit(FALLINGWALLSLIDE)
