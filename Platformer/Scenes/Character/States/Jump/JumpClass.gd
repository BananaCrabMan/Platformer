class_name JumpingState
extends BaseState

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

@export var jumpHeight : float
@export var jumpPeak : float
@export var jumpDecent: float

@onready var jumpVelocity: float = ((2 * jumpHeight) / jumpPeak) * -1
@onready var jumpGravity: float = ((-2 * jumpHeight) / (jumpPeak * jumpPeak)) * -1
@onready var fallGravity: float = ((-2 * jumpHeight) / (jumpDecent * jumpDecent)) * -1

func get_gravity():
	return jumpGravity if player.velocity.y < 0 else fallGravity
