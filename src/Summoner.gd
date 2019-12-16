extends KinematicBody2D

const enemy_zombie = preload("res://Zombie_Summon.tscn")

export var max_health = 4
var health

func _ready():
	health = max_health
	spawn()
	pass
	
	

func spawn():
	while true:
		$Sprite.play("Summon")
		var enemy = enemy_zombie.instance()
		get_node("SpawnPoint/AnchorPoint").add_child(enemy)
		yield($Sprite, "animation_finished")
	pass
	

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