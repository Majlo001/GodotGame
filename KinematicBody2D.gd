extends KinematicBody2D

var SSPEED = 170
var SPEED = 150
var GRAVITY = 10
var JUMP = -300
var FLOOR = Vector2(0, -1)

var timer
var attack_delay = 1
var attack = false

var velocity = Vector2()

func timing():
	if Timer.set_timer_falue(1):
		attack = false

func get_input():
	#atak
	if Input.is_action_just_pressed("action_attack"):
		attack = true
	elif attack == true:
		$Sprite.play("Attack")
		timer = Timer.new()
		timer.set_one_shot(true)
		timer.set_wait_time(attack_delay)
		timer.connect("timeout",self,"on_timeout_complete")
		add_child(timer)
		timer.start()
		velocity.x = 0
		#ruch w prawo
	elif Input.is_action_pressed("move_right"):
		velocity.x = SPEED
		$Sprite.flip_h = false
		$Sprite.play("Run")
	#ruch w lewo
	elif Input.is_action_pressed("move_left"):
		velocity.x = -SPEED
		$Sprite.flip_h = true
		$Sprite.play("Run")
	#bezruch
	else: 
		velocity.x = 0 
		$Sprite.play("Idle-NoSword")
	#skok
	if is_on_floor():
		if attack ==false:
			if Input.is_action_just_pressed("action_jump"):
				velocity.y = JUMP
	else:
		$Sprite.play("Jump")
	#ślizg
	if Input.is_action_pressed("action_slide"):
		if $Sprite.flip_h == true:
			velocity.x = -SSPEED
			$Sprite.play("Slide")
		elif $Sprite.flip_h == false:
			velocity.x = SSPEED
			$Sprite.play("Slide")

	velocity.y += GRAVITY
	
		

func on_timeout_complete():
	attack  = false

func _physics_process(delta):
	
	get_input()

	
	velocity = move_and_slide(velocity,FLOOR)
