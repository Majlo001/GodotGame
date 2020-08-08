extends Area2D

func _on_Coin_body_entered(body):
	if body is preload("res://Janek.gd"):
		print("coin")
		queue_free()
		
		
func _on_coin_area_enter(_area):  
	pass
	
func _on_coin_area_enter_shape(_area_id, _area, _area_shape, _area_shape):
	pass

func _on_body_entered(_body):
	pass 
d
