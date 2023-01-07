extends Node2D


onready var rua = $rua
onready var rua2 = $rua2
var vel : float = 20.0
var initial_position
func _ready():
	initial_position = rua.global_position.x
	
func _process(delta):
	print(rua.global_position.x)
	#loop rua
	rua.global_position.x-=delta*vel
	rua2.global_position.x-=delta*vel
	
	if rua.global_position.x <= 0:
		rua.global_position.x += initial_position*2-(vel*delta)
	if rua2.global_position.x <= 0:
		rua2.global_position.x += initial_position*2-(vel*delta)
	
