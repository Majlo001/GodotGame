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
var inv = false

var invenotry = load("Inventory.tscn")
var node = invenotry.instance()

var velocity = Vector2()


func get_input():
	var friction = false
	attack_anim = "Attack" +str(anim_numb)

	#inventarz
	if Input.is_action_just_pressed("action_inventory"):
		if inv == false:
			add_child(node)
			inv = true
		elif inv == true:
			remove_child(node)
			inv = false

	if attacking == false:
			
		#ruch w prawo
		if Input.is_action_pressed("move_right"):
			velocity.x = SPEED
			$Sprite.flip_h = false
			if $Timer2.time_left > 0:
				$Sprite.play("Run-Sword")
			else:
				$Sprite.play("Run")
			
		#ruch w lewo
		elif Input.is_action_pressed("move_left"):
			velocity.x = -SPEED
			$Sprite.flip_h = true
			if $Timer2.time_left > 0:
				$Sprite.play("Run-Sword")
			else:
				$Sprite.play("Run")
			
		#bezruch
		else:
			friction = true
			
		if is_on_floor():
			if friction == true:
				velocity.x = 0
				if $Timer2.time_left > 0:
					$Sprite.play("Idle-Sword")
				else:
					$Sprite.play("Idle-NoSword")
				
			
		#ślizg
		if Input.is_action_just_pressed("action_slide"):
			if is_on_floor():
				dash()
#			
		if SPEED == 500 and friction == false:
			$Sprite.play("Slide")
			
		#skok
		if is_on_floor():
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

func dash():
	SPEED = 500
	$Timer3.start()

func attack():
	if is_on_floor():
		attacking = true
		velocity.x = 0
		if $Sprite.flip_h == false:
			self.position += Vector2(15, 0)
		else:
			self.position -= Vector2(15, 0)
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

func _on_Timer3_timeout():
	SPEED = 150

func _on_Coin_body_entered(body):
	pass # replace with function body
