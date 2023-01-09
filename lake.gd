extends Node

onready var light = $Light2D
onready var fog = $fog
var wave : float = 0
func _ready():
	pass
func _process(delta):
	wave +=delta*2
	if(wave>999):
		wave -=999
	light.texture.noise_offset.y+=1*delta
	light.texture.noise_offset.x-=1*delta

	#light.texture.noise.period=sin(wave)*5+0.75
