extends JumpingState

@export var timer: float = 0.1
@export var coyoteTimer: float = 0.2
@export var spd : float = 60

var bufferTime: float = 0
var coyoteTime: float = 0

func enter():
	bufferTime = 0
	coyoteTime = coyoteTimer

func input(event: InputEvent):
	if Input.is_action_just_pressed("Jump"):
		bufferTime = timer
		if coyoteTime > 0 and !player.jumped:
			return JumpState
	return null

func process(delta: float):
	bufferTime -= delta
	return null

func physics_process(delta: float):
	var dir = (Input.get_action_strength("Right") - Input.get_action_strength("Left"))
	
	coyoteTime -= delta
	
	if dir == -1:
			player.sprite.flip_h = true
	elif dir == 1:
			player.sprite.flip_h = false
	
	player.velocity.x = dir * spd
	player.velocity.y += get_gravity() * delta
	player.move_and_slide()
	
	if player.is_on_floor():
		player.jumped = false
		if bufferTime > 0:
			return JumpState
		if dir != 0:
			if Input.is_action_pressed("Sneak"):
				return SneakState
			return WalkState
		else:
			return IdleState
	return null
