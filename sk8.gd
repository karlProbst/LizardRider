extends KinematicBody2D

enum States {IDLE, WALKING, MANUAL}
var state : int = States.IDLE
var delta : int = 0
var velocity = Vector2()
export (int) var speed = 200

# Called when the node enters the scene tree for the first time.
onready var skate_sprite = $AnimatedSprite
func _ready():
	pass
	skate_sprite.animation="walking"

func _process(delta):
	delta = delta
	match state:
		States.IDLE:
			skate_sprite.animation="idle"
		States.WALKING:
			skate_sprite.animation="walking"
		States.MANUAL:
			skate_sprite.animation="manual"
			#if skate_sprite.frame==2:
			#	skate_sprite.frame=1
			#	skate_sprite.play()
				
			print(skate_sprite.frame)
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
