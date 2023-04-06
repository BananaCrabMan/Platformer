extends JumpingState

@export var spd : float = 60

func enter():
	player.velocity.y = jumpVelocity
	player.jumped = true

func physics_process(delta):
	var dir = (Input.get_action_strength("Right") - Input.get_action_strength("Left"))
	if dir == -1:
			player.sprite.flip_h = true
	elif dir == 1:
			player.sprite.flip_h = false
	
	player.velocity.x = dir * spd
	player.velocity.y += get_gravity() * delta
	player.move_and_slide()
	
	if Input.is_action_just_released("Jump"):
		player.velocity.y *= 0.5
	
	if player.velocity.y > 0:
		return FallState
	
	if player.is_on_floor():
		if dir != 0:
			if Input.is_action_just_pressed("Sneak"):
				return SneakState
			return WalkState
		else:
			return IdleState
	return null

