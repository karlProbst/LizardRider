extends Node

onready var lake = $Lake
onready var lake2 = $Lake2
onready var fog = $fog
onready var timer = $Timer
onready var timer2 = $Timer2
var wave : float = 0
onready var Delta = 1
var lock = false
var wait_time=1.0/3
func _ready():
	timer.wait_time=wait_time
	timer2.wait_time=wait_time
func _process(delta):
	Delta=delta
	if !lock:
		if timer.time_left<wait_time/2:
			timer2.start()
			lock=true

	#light.texture.noise.period=sin(wave)*5+0.75
func Draw_waves(l,t):
	wave +=Delta*20000
	if(wave>999):
		wave -=999
	l.texture.noise_offset.y+=15*Delta
	l.texture.noise_offset.x-=15*Delta
	$Gradient.position.y-=sin(wave)/2
	t.start()


func _on_Timer_timeout():
	Draw_waves(lake,timer)


func _on_Timer2_timeout():
	Draw_waves(lake2,timer2)
