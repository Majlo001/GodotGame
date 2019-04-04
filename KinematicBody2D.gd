extends KinematicBody2D

var SSPEED = 170
var SPEED = 150
var GRAVITY = 10
var JUMP = -300
var FLOOR = Vector2(0, -1)

var attack_delay = 1
var attacking = false
var attack_anim = null
var anim_numb = 1
var attack = false
var inv = false

var invenotry = load("Inventory.tscn")
var node = invenotry.instance()

var velocity = Vector2()


func get_input():
	var friction = false
	attack_anim = "Attack" +str(anim_numb)
	print(anim_numb)


	if attacking == false:
			
		#ruch w prawo
		if Input.is_action_pressed("move_right"):
			velocity.x = SPEED
			$Sprite.flip_h = false
			$Sprite.play("Run")
			
		#ruch w lewo
		elif Input.is_action_pressed("move_left"):
			velocity.x = -SPEED
			$Sprite.flip_h = true
			$Sprite.play("Run")
			
		else:
			friction = true
			
		if is_on_floor():
			if friction == true:
				velocity.x = 0
				if $Timer2.time_left > 0:
					$Sprite.play("Idle-Sword")
				else:
					$Sprite.play("Idle-NoSword")
				
		#bezruch
#		else: 
#			velocity.x = 0 
#			$Sprite.play("Idle-NoSword")
			
			
		#ślizg
		if Input.is_action_pressed("action_slide"):
			if $Sprite.flip_h == true:
				self.velocity -= Vector2(150, 0)
				$Sprite.play("Slide")
			elif $Sprite.flip_h == false:
				self.velocity += Vector2(150, 0)
				$Sprite.play("Slide")
			
		#skok
		if is_on_floor():
	
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
		
		
	#inventarz
	elif Input.is_action_just_pressed("action_inventory"):
		if inv == false:
			add_child(node)
			inv = true
		elif inv == true:
			remove_child(node)
			inv = false
		
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
			
			#atak
		if Input.is_action_just_pressed("action_attack"):
			$Timer.start()
			$Timer2.start()
			attack()
			
			if $Timer.time_left > 0:
				anim_numb += 1
			
			if anim_numb == 4:
				anim_numb = 1




	velocity.y += GRAVITY
	
	#ESC wywala gre i elo
func _unhandled_input(event):
	if event is InputEventKey:
		if event.pressed and event.scancode == KEY_ESCAPE:
			get_tree().quit()


func attack():
	attacking = true
	velocity.x = 0
	if $Sprite.flip_h == false:
		self.position += Vector2(20, 0)
	else:
		self.position -= Vector2(20, 0)
	$Sprite.play(attack_anim)
	yield($Sprite, "animation_finished")
	attacking = false


func _physics_process(delta):
	
	get_input()
	
	
	velocity = move_and_slide(velocity,FLOOR)


func _on_Timer_timeout():
	anim_numb = 1


func _on_Timer2_timeout():
	pass # replace with function body
