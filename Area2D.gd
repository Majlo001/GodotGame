extends Area2D

var taken = false

export (bool) var jeden

func _on_Coin_body_entered(body):
	if not taken and body is preload("res://KinematicBody2D.gd"):
		taken = true
		print("coin")
		
		if jeden == true:
			queue_free()
		
		
func _on_coin_area_enter(area):  
	pass
	
func _on_coin_area_enter_shape(area_id, area, area_shape, area_shape):
	pass

func _on_body_entered(body):
	pass # replace with function body
