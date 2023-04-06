extends BaseState

@export var jumpNode : NodePath
@export var fallNode : NodePath
@export var walkNode : NodePath
@export var sneakNode : NodePath
@export var dashNode : NodePath

@onready var JumpState: BaseState = get_node(jumpNode)
@onready var FallState: BaseState = get_node(fallNode)
@onready var WalkState: BaseState = get_node(walkNode)
@onready var SneakState: BaseState = get_node(sneakNode)
@onready var DashState: BaseState = get_node(dashNode)
var AttackState: BaseState

func enter():
	player.velocity.x = 0

func input(event:InputEvent):
	if Input.is_action_just_pressed("Left") or Input.is_action_just_pressed("Right"):
		if Input.is_action_pressed("Sneak"):
			return SneakState
		return WalkState
	elif Input.is_action_just_pressed("Jump"):
		return JumpState
	elif Input.is_action_just_pressed("Dash"):
		return DashState
	return null

func physics_process(delta: float):
	if Input.is_action_pressed("AttackPrimary") and player.reloadTime <= 0:
		return AttackState
	
	player.velocity.y += player.gravity
	player.move_and_slide()
	
	if !player.is_on_floor():
		return FallState
	return null
