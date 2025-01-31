# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name PlayerState extends State

const IDLE = "Idle"
const RUNNING = "Running"
const JUMPING = "Jumping"
const FALLING = "Falling"
const GLIDING = "Gliding"
const CROUCHING = "Crouching"
const CRAWLING = "Crawling"
const DOUBLEJUMP = "DoubleJump"
const FALLINGDBLJUMP = "FallingDblJump"
const COYOTEJUMP = "CoyoteJump"
const GLIDINGJUMP = "GlidingJump"
const FALLINGGLIDE = "FallingGlide"
const WALLSLIDE = "WallSlide"
const WALLKICK = "WallKick"
const FALLINGWALLSLIDE ="FallingWallSlide"
#const NPCJUMP = "NPCJump"

var player: Player


@export var jump_count = 0
@export var max_jumps = 2

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null)
	
