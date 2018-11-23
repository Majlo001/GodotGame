extends KinematicBody2D

var SPEED = 100
var GRAVITY = 30
var FLOOR = Vector2(0, -1)

var velocity = Vector2()

var direction = 1

func _ready():
	pass


func _physics_process(delta):
	
	velocity.x = SPEED * direction

	velocity.y += GRAVITY
		
	velocity = move_and_slide(velocity,FLOOR)
	
	if is_on_wall():
		direction = direction * -1
		$Sprite.flip_h = true
		$RayCast2D.position.x *= -1
	
	
	