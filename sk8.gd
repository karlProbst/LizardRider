extends KinematicBody2D

enum States {IDLE, WALKING, MANUAL}
var state : int = States.IDLE
var delta : int = 0
var velocity = Vector2()
export (int) var speed = 200
onready var rua_speed =  $"/root/Main".vel
# Called when the node enters the scene tree for the first time.
onready var skate_sprite = $AnimatedSprite
onready var skate_sprite2 = $AnimatedSprite2
func _ready():
	pass
	state=States.WALKING

func _process(delta):
	rua_speed =  $"/root/Main".vel
	skate_sprite2.speed_scale=rua_speed/40
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
			#if skate_sprite.frame==2:
			#	skate_sprite.frame=1
			#	skate_sprite.play()
				
			
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
