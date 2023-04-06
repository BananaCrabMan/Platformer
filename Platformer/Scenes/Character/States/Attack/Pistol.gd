extends AttackingState

@onready var bullet: PackedScene = preload("res://Scenes/Character/Bullets/bullet.tscn") 
@onready var entities: Node2D = get_node("/root/World/Entities")

func enter():
	set_values()
	var shot = bullet.instantiate()
	shot.position = player.position
	entities.add_child(shot)
