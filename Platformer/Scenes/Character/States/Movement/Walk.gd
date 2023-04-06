extends MoveState

func input(event: InputEvent):
	
	if Input.is_action_just_pressed("Sneak"):
		return SneakState
	
	if Input.is_action_just_pressed("Jump"):
		return JumpState
	
	if Input.is_action_just_pressed("Dash"):
		return DashState
	
	return null
