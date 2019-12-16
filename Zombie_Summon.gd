extends KinematicBody2D

onready var Player = get_parent().get_parent().get_parent().get_parent().get_node("Janek")

var SPEED = 90
var GRAVITY = 10
var max_GRAVITY = 90
var FLOOR = Vector2(0, -1)

# onready var body = $CollisionShape2D

var velocity = Vector2(0, 0)

#export(String) var weapon_scene_path = "res://weapons/Weapon.tscn"
var weapon = null
var weapon_path = ""
var attacking = false

export var max_health = 4
var health

var react_time = 200
var dir = 0
var next_dir = 0
var next_dir_time = 0

var next_jump_time = -1

var target_player_dsit = 70

var eye_reach = 15
var vision = 200

var timing = 0

var dummy = null

func _ready():
	set_process(true)
	health = max_health
	
	
	var weapon_instance = load("res://weapons/Weaponz.tscn").instance()
	var weapon_anchor = $WeaponSpawnPoint/WeaponAnchorPoint
	weapon_anchor.add_child(weapon_instance)

	weapon = weapon_anchor.get_child(0)

	weapon_path = weapon.get_path()
	weapon.connect("attack_finished", self, "_on_Weapon_attack_finished")
	$Timer.start()
	
	dummy = get_parent().get_node("Zombie")

func set_dir(target_dir):
	if next_dir != target_dir:
		next_dir = target_dir
		next_dir_time = OS.get_ticks_msec() + react_time

func sees_player():
#	var positioning = dummy.position
	var eye_center = position
	var eye_top =eye_center + Vector2(0, -eye_reach)
	var eye_left =eye_center + Vector2(-eye_reach, 0)
	var eye_right =eye_center + Vector2(eye_reach, 0)
	
	var player_pos = Player.position
	var player_extents = Player.get_node("CollisionShape2D").shape.extents - Vector2(1, 1)
	var top_left = player_pos + Vector2(-player_extents.x, -player_extents.y)
	var top_right = player_pos + Vector2(player_extents.x, -player_extents.y)
	var bottom_left = player_pos + Vector2(-player_extents.x, player_extents.y)
	var bottom_right = player_pos + Vector2(player_extents.x, player_extents.y)
	
	var space_state = get_world_2d().direct_space_state
	
	for eye in [eye_center, eye_top, eye_left, eye_right]:
		for corner in [top_left, top_right, bottom_left, bottom_right]:
			if (corner - eye).length() > vision:
				continue
			var collision = space_state.intersect_ray(eye, corner, [], 1)
			if collision and collision.collider.name == "Janek":
				return true
	return false

func _physics_process(_delta):
	print (sees_player())
	
	if attacking == false:
		
		if  Player.position.x < position.x - target_player_dsit and sees_player():
			$Sprite.play("Walk")
			set_dir(-1)
		elif Player.position.x > position.x + target_player_dsit and sees_player():
			$Sprite.play("Walk")
			set_dir(1)
		elif Player.position.x > position.x - target_player_dsit or Player.position.x < position.x + target_player_dsit and sees_player():
			print("spelnia")
#			$Timer.start()
			attack()
		else:
			$Sprite.play("Idle")
			set_dir(0)
		
		if OS.get_ticks_msec() > next_dir_time:
			dir = next_dir
		
		
		if OS.get_ticks_msec() > next_jump_time and next_jump_time != -1 and is_on_floor():
			if Player.position.y < position.y - 40 and sees_player():
				velocity.y = -300
			next_jump_time = -1
		
		
		velocity.x = dir * SPEED
		
		if Player.position.y < position.y - 40 and next_jump_time == -1 and sees_player():
			next_jump_time = OS.get_ticks_msec() + react_time
		
		velocity.y += GRAVITY
	
#	if Player.position.x < position.x - target_player_dsit or Player.position.x > position.x + target_player_dsit:
#		$Timer.start()

	
	if is_on_floor() and velocity.y > 0:
		velocity.y = 0
	
	velocity = move_and_slide(velocity, FLOOR)
	
	if dir == -1:
		$Sprite.flip_h = false
	elif dir == 1:
		$Sprite.flip_h = true
	
#	if attacking == false:
#		$Sprite.play("Walk")
#		
#		velocity.x = -SPEED * direction
#	
		if set_process(false):
			$Timer2.start()
#		
#		velocity = move_and_slide(velocity,FLOOR)
#		
#	
#	velocity.y += GRAVITY
	if $Sprite.flip_h == true:
		$WeaponSpawnPoint.rotation = 0
	else:
		$WeaponSpawnPoint.rotation = 22
#	
#	if is_on_wall():
#		direction *= -1
#		$RayCast2D.position.x *= -1
#		if direction == 1:
#			$Sprite.flip_h = false
#		else:
#			$Sprite.flip_h = true

func attack():
	if is_on_floor():
		attacking = true
		velocity.x = 0
		velocity.y = 0
#		if $Sprite.flip_h == true:
#			self.position += Vector2(15, 0)
#		else:
#			self.position -= Vector2(15, 0)
		$Sprite.play("Attack")
		weapon.attack()
		yield($Sprite, "animation_finished")
#		$Timer.start()
		attacking = false

func take_damage(count):
#	if current_state == DEAD:
#		return
	if (health == 4):
		var Health3 = get_parent().get_node("Zombie/Sprite/TileMap2/heart4")
		Health3.hide()
	
	if (health == 3):
		var Health2 = get_parent().get_node("Zombie/Sprite/TileMap2/heart3")
		Health2.hide()
	
	if (health == 2):
		var Health1 = get_parent().get_node("Zombie/Sprite/TileMap2/heart2")
		Health1.hide()
		
	if (health == 1):
		set_process(false)

	health -= count
	if health <= 0:
		health = 0
		queue_free()
#		emit_signal("died")
		return

func _on_Timer_timeout():
	attack()


func _on_Timer2_timeout():
	set_process(true)
