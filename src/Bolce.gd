extends Area2D

func _on_Bolce_body_entered(body):
	if body.name == "Janek":
		print("bolce")
		queue_free()