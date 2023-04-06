class_name AttackingState
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

@export var attackTime: float = 0.5
@export var damage: float = 1
@export var reloadTime: float = 2.5
@export var chamberSize: int = 2
@export var recoilMax: float = 20
@export var airFriction: float = 2
@export var groundFriction: float = 4

var direction: int = 0
var time: float = 0
var recoil: float = 0
var recoilBuffer: float = 180
var friction: float = 0

func enter():
	set_values()

func set_values():
	
	if player.is_on_floor():
		friction = groundFriction
	else:
		friction = airFriction
	
	player.jumped = true
	if player.sprite.flip_h:
		direction = 1
	else:
		direction = -1
	
	player.chamber += 1
	time = attackTime
	recoil = recoilMax

func physics_process(delta: float):
	var dir = (player.get_global_mouse_position() - player.position).normalized()* -1
	player.velocity += dir * recoil
	player.velocity.y += friction 
	
	var old_sign = sign(player.velocity.x)
	player.velocity.x -= friction * dir.x
	var new_sign = sign(player.velocity.x)
	
	if old_sign != new_sign:
		player.velocity.x = 0
		
	player.move_and_slide()
	
	if recoil > 0:
		recoil = max(recoil - delta * recoilBuffer,0)
		print(recoil)
		
	if time > 0:
		time -= delta
		return null
	
	if player.chamber >= chamberSize:
		player.reloadTime = reloadTime
		player.chamber = 0
	if Input.is_action_pressed("Left") or Input.is_action_pressed("Right"):
		if Input.is_action_pressed("Sneak"):
			return SneakState
		return WalkState
	player.reloadTemp = reloadTime
	return IdleState
