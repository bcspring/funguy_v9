# Character that moves and jumps.
class_name Player extends CharacterBody2D

## Horizontal speed in pixels per second.
@export var speed := 110.0
## Vertical acceleration in pixel per second squared.
@export var gravity := 800.0
## Vertical speed applied when jumping.
@export var jump_impulse := 235.0

@export var glide_max_speed := 100.0 #130 default
@export var glide_acceleration := 50.0 #ability to control direction of descent
@export var glide_gravity := 50.0 #40 default
@export var glide_jump_impulse := 160.0 #160 default

@export var wallslide_gravity := 770.0 #700 default
@export var wallkick_jump_impulse := 240.0 #160 default

@onready var fsm := $StateMachine
@onready var label := $Label


#ANIMATION AND SFX

@onready var double_jump_sfx: AudioStreamPlayer2D = $DoubleJumpSFX
@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D




func _process(_delta: float) -> void:
	label.text = fsm.state.name
	if Input.is_action_pressed("move_left"):
		$AnimatedSprite2D.flip_h = true
	if Input.is_action_pressed("move_right"):
		$AnimatedSprite2D.flip_h = false
