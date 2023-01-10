extends KinematicBody2D

enum States {IDLE, WALKING, MANUAL,PADDLING,OLLIE,FALLING}
var state : int = States.IDLE
var delta : int = 0
var velocity = Vector2()
export (int) var speed = 0
export (int) var accel = 4500
export (int) var desaccel = 20

onready var rua =  $"/root/Main"
onready var ollie_timer =  $Ollie_Timer
# Called when the node enters the scene tree for the first time.
onready var guy = $Guy
onready var lizard = $Lizard
var ollie_state : int = 0
var ollie_lock = false
var height : float = 0

func _ready():
	pass
	state=States.WALKING

func _process(delta):
	
	rua.vel=speed
	if speed>0:
		if(state==States.WALKING or state==States.WALKING):
			speed-=desaccel*delta
	else:
		speed=0
	if state==States.WALKING or state==States.PADDLING:
		lizard.speed_scale=rua.vel/40
	delta = delta
	if state!=States.OLLIE:
		ollie_state=0
	match state:
		States.IDLE:
			ollie_lock=false
			guy.animation="idle"
			lizard.animation="idle"
		States.WALKING:
			ollie_lock=false
			guy.animation="walking"
			lizard.animation="walking"
		States.MANUAL:
			guy.animation="manual"
			lizard.animation="manual"
			if !ollie_lock and Input.is_action_pressed("ui_right"):
				state=States.OLLIE
				
		States.PADDLING:
			ollie_lock=false
			guy.animation="paddling"
			lizard.animation="walking"
			if guy.frame==2:
				speed+=accel/(speed/4+1)*delta
				
			if guy.frame==4:
				state = States.WALKING
				if Input.is_action_pressed("ui_right") and state!=States.MANUAL:
					guy.frame=0
					state = States.PADDLING
		States.OLLIE:	
			match ollie_state:
				0:
					ollie_lock=true
					guy.animation="jump"
					lizard.animation="jump"
					lizard.speed_scale=10
					
					
					
					
					if lizard.frame==3:
						lizard.speed_scale=2
						height=3
						ollie_state=1
						
				1:
					guy.animation="jump"
					lizard.animation="air"
					guy.frame=4
					if height<1.5:
						state=States.FALLING
		States.FALLING:
			if(height>0.1):
				lizard.animation="landing"
			else:
				lizard.animation="landed"
			if height==0:
				
				state=States.WALKING
				if Input.is_action_pressed("ui_left"):
					ollie_timer.start()
					state = States.MANUAL
					ollie_lock=false
	if height>0:
		height-=delta*3
	else: 
		height = 0
		
	var x = 3-height
	var height2=x*x*x-4.5*x*x+4.5*x
	
	
	velocity = move_and_slide(Vector2(0,-height2*80))
	
func _input(event):
	if event.is_action_pressed("ui_left") and (state==States.PADDLING or state==States.WALKING) and state!=States.OLLIE:
		state = States.MANUAL
		ollie_timer.start()
	if event.is_action_released("ui_left") and state!=States.OLLIE:
		state = States.WALKING
	if event.is_action_released("ui_up"):
		global_position.y +=100*delta
	if event.is_action_released("ui_down"):
		global_position.y -=100*delta
	if event.is_action_pressed("ui_right") and state!=States.MANUAL and state!=States.OLLIE:
		state = States.PADDLING

#first manual timer
func _on_Timer_timeout():
	ollie_lock=true
