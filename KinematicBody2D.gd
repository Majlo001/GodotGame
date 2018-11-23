extends KinematicBody2D

var SPEED = 150
var GRAVITY = 10
var JUMP = -250
var FLOOR = Vector2(0, -1)

var velocity = Vector2()

var on_ground = false


func _physics_process(delta):
	
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("Run")
	else:
		velocity.x = 0
		$Sprite.play("Idle")
		
	if Input.is_action_pressed("ui_up"):
		if on_ground == true:
			velocity.y = JUMP
			$Sprite.play("Jump")
			on_ground == false


	velocity.y += GRAVITY
	
	if is_on_floor():
		on_ground = true
	else:
		on_ground = false
		
	velocity = move_and_slide(velocity,FLOOR)