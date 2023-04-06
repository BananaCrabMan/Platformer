extends Node2D

@export var startState: NodePath

var currentState: BaseState

func change_state(newState: BaseState):
	if currentState:
		currentState.exit()
	
	currentState = newState
	print(newState)
	currentState.enter()

func init(player: Player) -> void:
	for child in get_children():
		child.player = player
	
	change_state(get_node(startState))

func physics_process(delta: float):
	var newState = currentState.physics_process(delta)
	if newState:
		change_state(newState)

func process(delta: float):
	var newState = currentState.process(delta)
	if newState:
		change_state(newState)

func input(event: InputEvent):
	var newState = currentState.input(event)
	if newState:
		change_state(newState)
