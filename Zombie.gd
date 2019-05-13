extends KinematicBody2D

var SPEED = 70
var GRAVITY = 30
var FLOOR = Vector2(0, -1)

var velocity = Vector2()

export var max_health = 2
var health

var direction = 1

func _ready():
	health = max_health
	pass


func _physics_process(delta):
	
	$Sprite.play("Walk")
	
	velocity.x = SPEED * direction

	velocity.y += GRAVITY
		
	velocity = move_and_slide(velocity,FLOOR)
	
	if is_on_wall():
		direction *= -1
		$RayCast2D.position.x *= -1
		if direction == 1:
			$Sprite.flip_h = false
		else:
			$Sprite.flip_h = true

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