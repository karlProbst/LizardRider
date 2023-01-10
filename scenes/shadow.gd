extends MeshInstance2D


onready var guy = $"/root/Main/Dude"
var initial_scale=scale
var distance
func _ready():
	pass
	


func _process(delta):
	pass
	


func _on_Timer_timeout():
	
	distance=self.position.y-guy.position.y
	scale.x/=distance/20
	if scale>initial_scale:
		scale=initial_scale
	if scale.x<0.3:
		scale.x=0.3
	$Timer.start()
