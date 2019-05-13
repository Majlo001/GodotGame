extends KinematicBody2D

var SPEED = 70
var GRAVITY = 30
var FLOOR = Vector2(0, -1)

onready var body = $CollisionShape2D

var velocity = Vector2()

export(String) var weapon_scene_path = "res://weapons/Weapon.tscn"
var weapon = null
var weapon_path = ""
var attacking = false

export var max_health = 4
var health

var direction = 1

func _ready():
	health = max_health
	
	
	var weapon_instance = load("res://weapons/Weapon.tscn").instance()
	var weapon_anchor = $WeaponSpawnPoint/WeaponAnchorPoint
	weapon_anchor.add_child(weapon_instance)

	weapon = weapon_anchor.get_child(0)

	weapon_path = weapon.get_path()
	weapon.connect("attack_finished", self, "_on_Weapon_attack_finished")
	$Timer.start()


func _physics_process(delta):
	if attacking == false:
		$Sprite.play("Walk")
		
		velocity.x = SPEED * direction
	
		velocity.y += GRAVITY
		
		velocity = move_and_slide(velocity,FLOOR)
		
	

	
	if $Sprite.flip_h == true:
		$WeaponSpawnPoint.rotation = 22
	else:
		$WeaponSpawnPoint.rotation = 0
	
	if is_on_wall():
		direction *= -1
		$RayCast2D.position.x *= -1
		if direction == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true

func attack():
	if is_on_floor():
		attacking = true
		velocity.x = 0
		if $Sprite.flip_h == false:
			self.position += Vector2(15, 0)
		else:
			self.position -= Vector2(15, 0)
		$Sprite.play("Attack")
		weapon.attack()
		yield($Sprite, "animation_finished")
		$Timer.start()
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
		emit_signal("died")
		return

func _on_Timer_timeout():
	attack()
