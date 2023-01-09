extends KinematicBody2D

enum States {IDLE, WALKING, MANUAL,PADDLING}
var state : int = States.IDLE
var delta : int = 0
var velocity = Vector2()
export (int) var speed = 0
export (int) var accel = 4000
export (int) var desaccel = 20

onready var rua =  $"/root/Main"
# Called when the node enters the scene tree for the first time.
onready var skate_sprite = $AnimatedSprite
onready var skate_sprite2 = $AnimatedSprite2
func _ready():
	pass
	state=States.WALKING

func _process(delta):
	rua.vel=speed
	if speed>0:
		speed-=desaccel*delta
	else:
		speed=0
	skate_sprite2.speed_scale=rua.vel/40
	delta = delta
	match state:
		States.IDLE:
			skate_sprite.animation="idle"
			skate_sprite2.animation="idle"
		States.WALKING:
			skate_sprite.animation="walking"
			skate_sprite2.animation="walking"
		States.MANUAL:
			skate_sprite.animation="manual"
			skate_sprite2.animation="manual"
		States.PADDLING:
			skate_sprite.animation="paddling"
			skate_sprite2.animation="walking"
			if skate_sprite.frame==2:
				speed+=accel/(speed/4+1)*delta
				
			if skate_sprite.frame==4:
				state = States.WALKING
				if Input.is_action_pressed("ui_right"):
					skate_sprite.frame=0
					state = States.PADDLING
			
	velocity = move_and_slide(velocity)
	
func _input(event):
	if event.is_action_pressed("ui_left"):
		state = States.MANUAL
	if event.is_action_released("ui_left"):
		state = States.WALKING
	if event.is_action_released("ui_up"):
		global_position.y +=100*delta
	if event.is_action_released("ui_down"):
		global_position.y -=100*delta
	if event.is_action_pressed("ui_right"):
		state = States.PADDLING
