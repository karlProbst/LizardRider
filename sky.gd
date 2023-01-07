extends Area2D

onready var light = $Light2D
var wave : float = 0
func _ready():
	pass
func _process(delta):
	wave +=delta*500
	if(wave>999):
		wave -=999
	light.texture.noise_offset.x+=10*delta
	light.texture.noise.lacunarity=sin(wave)
