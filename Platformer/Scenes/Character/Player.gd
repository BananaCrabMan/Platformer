class_name Player
extends CharacterBody2D

const TILE_SIZE: int = 16

@export var weapon: PackedScene
@export var gravity = 4

var jumped: bool = false
var chamber: int = 0
var reloadTime: float = 0
var reloadTemp: float = 0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var stateMachine: Node2D = $StateMachine
@onready var collision: CollisionShape2D = $CollisionShape2D
@onready var groundCheck: RayCast2D = $GroundCheck

func set_weapon():
	var attack = weapon.instantiate()
	attack.name = "Attack"
	stateMachine.add_child(attack)
	
	for name in stateMachine.get_children():
		var childName = name.name
		
		match childName:
			"Jump":
				attack.JumpState = name
			"Fall":
				attack.FallState = name
			"Walk":
				attack.WalkState = name
			"Sneak":
				attack.SneakState = name
			"Dash":
				attack.DashState = name
			"Attack":
				attack.AttackState = name
			"Idle":
				attack.IdleState = name
	
	for child in stateMachine.get_children():
		child.AttackState = attack

func _ready():
	set_weapon()
	stateMachine.init(self)

func _unhandled_input(event):
	stateMachine.input(event)

func _physics_process(delta):
	stateMachine.physics_process(delta)

func _process(delta):
	if reloadTime > 0:
		reloadTime -= delta
	if reloadTemp > 0:
		reloadTemp -= delta
	else:
		chamber = 0
	stateMachine.process(delta)
