extends Node2D


onready var rua = $Rua
onready var rua2 = $Rua2
onready var background = $Background
onready var background2 = $Background2
var vel : float = 0.0
var initial_position
var Delta 
var wave = 0
onready var light_node = $Light
func _ready():
	initial_position = rua.global_position.x
	
func LoopAround(node,node2,initial_position,scale):
	var velocity = Delta*vel
	#velocity*=2
	#velocity= round(velocity)
	#velocity/=2
	if(velocity>0 and velocity<1):
		wave+=Delta*(velocity*100)
		if(sin(wave)>0):
			velocity =1
		else:
			velocity = 0
	
	
	if velocity < 1 and velocity >0:
		velocity = velocity
	if node.global_position.x <= 0:
		node.global_position.x += initial_position*2-velocity
	if node2.global_position.x <= 0:
		node2.global_position.x += initial_position*2-velocity
	node.global_position.x-=velocity*scale
	node2.global_position.x-=velocity*scale
	node.position.x = round(node.position.x)
	node2.position.x = round(node2.position.x)
func _process(delta):
	Delta = delta
	#loop rua
	light_node.texture.noise_offset.x+=vel*delta
	LoopAround(rua,rua2,320,1)
	#LoopAround(background,background2,initial_position,0.1)
	

		
		
	#if Input.is_action_pressed("ui_right"):
	#	vel += 5*Delta
	#if Input.is_action_pressed("ui_left"):
	#	if vel>=0:
	#		vel -= 5*Delta
	#	if vel <0:
	#		vel = 0

	
