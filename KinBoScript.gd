extends KinematicBody2D



const MOTION_SPEED = 250 
var health = 100
var on_scene = false


func _ready():
	set_physics_process(true)
	on_scene = true
	pass
	
func _physics_process(delta):
	
	var motion = Vector2()
	var collision = Vector2()
	
	
	
	if (Input.is_action_pressed("ui_up")):
		motion += Vector2(0, -1)
	if (Input.is_action_pressed("ui_down")):
		motion += Vector2(0, 1)
	if (Input.is_action_pressed("ui_left")):
		motion += Vector2(-1, 0)
	if (Input.is_action_pressed("ui_right")):
		motion += Vector2(1, 0)
	
	motion = motion.normalized() * MOTION_SPEED * delta
	motion = move_and_collide(motion)
	
	collision = motion
	
	if(health <= 0):
		self.queue_free()	# śmierć...
		
		
#	if(motion):
#		print("Kolizja...")
#		get_node("Sprite").stop()
#	else:
#		get_node("Sprite").play()
	
	
func _on_VisibilityNotifier2D_enter_screen():
	on_scene = true
	pass
	
	
func _on_VisibilityNotifier2D_exit_screen():
	on_scene = false
	pass
	
	
func update_health(damage):
	health -= damage
	pass