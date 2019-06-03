extends KinematicBody2D

const FRICTION =-20
var SPEED = 100
var direction = 1
var velocity = 0

func _ready():
	set_process(true)

func _process(delta):
	velocity = SPEED * delta * direction
	move_and_collide(Vector2(velocity, 0))

func _on_Timer_timeout():
	if direction == 1:
		direction = -1
	else:
		direction = 1