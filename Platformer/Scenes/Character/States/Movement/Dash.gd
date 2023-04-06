extends MoveState

@export var dashTime : float = 0.4

var time : float = 0
var direction: int = 0
var dashSpd: float = 200

func enter():
	if !Input.is_action_pressed("Left") and !Input.is_action_pressed("Right"):
		time = dashTime/2
		
		if player.sprite.flip_h:
			direction = 1
		else:
			direction = -1
	else:
		time = dashTime
		
		if player.sprite.flip_h:
			direction = -1
		else:
			direction = 1

func input(event: InputEvent):
	return null

func get_movement_input():
	return direction

func physics_process(delta):
	player.velocity.x = direction * dashSpd
	player.velocity.y += player.gravity
	player.move_and_slide()

func process(delta: float):
	time -= delta
	
	if time > 0:
		return null
	else:	
		if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
			if Input.is_action_pressed("Sneak"):
				return SneakState
			return WalkState
		return IdleState
