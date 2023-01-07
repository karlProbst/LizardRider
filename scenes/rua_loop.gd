extends Node2D


onready var rua = $Rua
onready var rua2 = $Rua2
onready var background = $Background
onready var background2 = $Background2
var vel : float = 100.0
var initial_position
var Delta 
onready var light_node = $Light
func _ready():
	initial_position = rua.global_position.x
	
func LoopAround(node,node2,initial_position,scale):
	if node.global_position.x <= 0:
		node.global_position.x += initial_position*2-Delta*vel
	if node2.global_position.x <= 0:
		node2.global_position.x += initial_position*2-Delta*vel
	node.global_position.x-=Delta*vel*scale
	node2.global_position.x-=Delta*vel*scale
func _process(delta):
	Delta = delta
	print(rua.global_position.x)
	#loop rua
	light_node.texture.noise_offset.x+=vel*delta
					  
	
	LoopAround(rua,rua2,initial_position,1)
	LoopAround(background,background2,initial_position,0.01)
	

		
		
	if Input.is_action_pressed("ui_right"):
		vel += 50*Delta
	if Input.is_action_pressed("ui_left"):
		if vel>=0:
			vel -= 50*Delta
		if vel <0:
			vel = 0

	
