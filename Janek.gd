#warning-ignore-all:unused_variable
extends KinematicBody2D

#var SSPEED = 170
var SPEED = 150
var GRAVITY = 15
var JUMP = -350
var FLOOR = Vector2(0, -1)
var velocity = Vector2()


var strength = 10
var dexterity = 7
var durability = 18
var inteligence = 12
var charisma = 9

#export(String) var weapon_scene_path = "res://weapons/Weapon.tscn"
var weapon = null
var weapon_path = ""

export var max_health = 4
var health 
var score = 0

var can_move = true
var time_jump = true

#var attack_delay = 1
var attacking = false
var attack_anim = null
var anim_numb = 1

var inv = false
var invenotry = load("Inventory.tscn")
var node = invenotry.instance()
var dying = false

func _ready():
	set_process(true)
	health = max_health
	
	# Weapon setup
	var weapon_instance = load("res://weapons/Weapon.tscn").instance()
	var weapon_anchor = $WeaponSpawnPoint/WeaponAnchorPoint
	weapon_anchor.add_child(weapon_instance)

	weapon = weapon_anchor.get_child(0)

	weapon_path = weapon.get_path()
	weapon.connect("attack_finished", self, "_on_Weapon_attack_finished")




func get_input():
	var friction = false
	attack_anim = "Attack" +str(anim_numb)

	if dying == false:
		#inventarz
		if Input.is_action_just_pressed("action_inventory") and can_move == true:
			if inv == false:
				add_child(node)
				inv = true
			elif inv == true:
				remove_child(node)
				inv = false
	
		if attacking == false:
				
			#ruch w prawo
			if Input.is_action_pressed("move_right") and can_move == true:
				velocity.x = SPEED
				$Sprite.flip_h = false
				if $Timer2.time_left > 0:
					if is_on_floor():
						$Sprite.play("Run-Sword")
				else:
					if is_on_floor():
						$Sprite.play("Run")
				
			#ruch w lewo
			elif Input.is_action_pressed("move_left") and can_move == true:
				velocity.x = -SPEED
				$Sprite.flip_h = true
				if $Timer2.time_left > 0:
					if is_on_floor():
						$Sprite.play("Run-Sword")
				else:
					if is_on_floor():
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
			if Input.is_action_just_pressed("action_slide") and can_move == true:
				if is_on_floor():
					dash()
	#			
			if SPEED == 500 and friction == false:
				$Sprite.play("Slide")
				
			#skok
			if Input.is_action_pressed("action_jump") and can_move == true and time_jump == true:
#				$Timer4.start(-1)
				velocity.y = JUMP
				$Sprite.play("Jump")
			if is_on_floor():
				time_jump = true
			if Input.is_action_just_pressed("action_jump") and can_move == true and time_jump == true:
				$Timer4.start()
				
				
				#atak
			if Input.is_action_just_pressed("action_attack") and can_move == true:
				$Timer.start()
				$Timer2.start()
				attack()
				
				if $Timer.time_left > 0:
					anim_numb += 1
				
				if anim_numb == 4:
					anim_numb = 1

	velocity.y += GRAVITY
	

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
		weapon.attack()
		yield($Sprite, "animation_finished")
		attacking = false

func _process(delta):
	if $Sprite.flip_h == true:
		$WeaponSpawnPoint.rotation = 22
	else:
		$WeaponSpawnPoint.rotation = 0

func take_damage(count):
#	if current_state == DEAD:
#		return
	if (health == 4):
		var Health3 = get_parent().get_node("UI/UI/Health/Health3")
		Health3.hide()
	
	if (health == 3):
		var Health2 = get_parent().get_node("UI/UI/Health/Health2")
		Health2.hide()
	
	if (health == 2):
		var Health1 = get_parent().get_node("UI/UI/Health/Health1")
		Health1.hide()
		
	if (health == 1):
		var Health0 = get_parent().get_node("UI/UI/Health/Health0")
		Health0.hide()
		dying = true
		$Sprite.play("Die")
		yield($Sprite, "animation_finished")
		dying = false
		queue_free()
		get_tree().change_scene("res://Death.tscn")
#		var death_instance = load("res://Death.tscn").instance()
#		var death_anchor = $Death
#		death_anchor.add_child(death_instance)
		
	health -= count
	if health <= 0:
		health = 0
#		_change_state(DEAD)
#		emit_signal("died")
		return

#	_change_state(STAGGER)
#	emit_signal("health_changed", health)

func _physics_process(_delta):		#_delta zamiast delta (inernet podpowiedział)
	
	get_input()
	velocity = move_and_slide(velocity,FLOOR)


func _on_Timer_timeout():
	anim_numb = 1


func _on_Timer2_timeout():
	pass # replace with function body

func _on_Timer3_timeout():
	SPEED = 150



#onready var fps_label = get_node('fps_label')

#fps_label.set_text(str(OS.get_frames_per_second()))


func _on_Bolce_body_entered(body):
	var bolce = get_parent().get_node("Bolce/CollisionShape2D")
	if body.name == "Janek":
		var Health1 = get_parent().get_node("UI/UI/Health/Health1")
		var Health2 = get_parent().get_node("UI/UI/Health/Health2")
		var Health3 = get_parent().get_node("UI/UI/Health/Health3")
		var Health0 = get_parent().get_node("UI/UI/Health/Health0")
		Health0.hide()
		Health1.hide()
		Health2.hide()
		Health3.hide()
		dying = true
		velocity.x = 0
		$Sprite.play("Die")
		yield($Sprite, "animation_finished")
		dying = false
		queue_free()
		get_parent().get_node("Death/Death").show()


func _on_Timer4_timeout():
	time_jump = false
