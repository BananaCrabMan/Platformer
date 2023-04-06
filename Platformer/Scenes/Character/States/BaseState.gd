class_name BaseState
extends Node

@export var animationName: String

var player: Player

func enter():
	player.sprite.play(animationName)

func exit():
	pass
	
func input(event: InputEvent):
	return null

func process(delta: float):
	return null

func physics_process(delta: float):
	return null
