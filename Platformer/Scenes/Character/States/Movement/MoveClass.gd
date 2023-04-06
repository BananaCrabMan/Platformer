class_name MoveState
extends BaseState

@export var maxSpd: float = 60
@export var spd : float = 0
@export var acceleration: float = 10
@export var deceleration: float = 10
@export var slopeSpd: float = 180

@export var jumpNode: NodePath
@export var fallNode: NodePath
@export var dashNode: NodePath
@export var idleNode: NodePath
@export var walkNode: NodePath
@export var sneakNode: NodePath

@onready var JumpState: BaseState = get_node(jumpNode)
@onready var FallState: BaseState = get_node(fallNode)
@onready var DashState: BaseState = get_node(dashNode)
@onready var IdleState: BaseState = get_node(idleNode)
@onready var WalkState: BaseState = get_node(walkNode)
@onready var SneakState: BaseState = get_node(sneakNode)
var AttackState: BaseState

var prevDir: float = 1

func enter():
	spd = 0

func input(event: InputEvent):
	if Input.is_action_just_pressed("Jump"):
		return JumpState
	
	if Input.is_action_just_pressed("Dash"):
		return DashState
	
	return null

func physics_process(delta: float):
	if !player.is_on_floor():
		if player.groundCheck.is_colliding():
			var normal = player.groundCheck.get_collision_normal()
			if normal.dot(Vector2.UP) < .72:
				player.velocity.y = slopeSpd
		else:
			return FallState
	
	var dir: float = (Input.get_action_strength("Right") - Input.get_action_strength("Left"))
	
	if dir == -1:
			player.sprite.flip_h = true
			prevDir = dir
	elif dir == 1:
			player.sprite.flip_h = false
			prevDir = dir
	
	if dir == 0:
		if spd > 0:
			spd = max(spd - deceleration,0)
		else:
			return IdleState
	else:
		spd = min(spd + acceleration,maxSpd)
	
	player.velocity.x = prevDir * spd
	player.move_and_slide()
