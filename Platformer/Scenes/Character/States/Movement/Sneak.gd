extends MoveState

func enter():
	player.collision.shape.height = player.TILE_SIZE/2
	player.collision.position.y += player.TILE_SIZE/4
	
	return null

func input(event: InputEvent):
	
	if Input.is_action_just_released("Sneak"):
		return WalkState
	
	if Input.is_action_just_pressed("Jump"):
		return JumpState
	
	if Input.is_action_just_pressed("Dash"):
		return DashState
	
	return null

func exit():
	player.collision.shape.height = player.TILE_SIZE
	player.collision.position.y -= player.TILE_SIZE/4
	
	return null
