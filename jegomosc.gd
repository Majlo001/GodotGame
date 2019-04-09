extends Area2D

var interact = false


func _on_Area2D_body_entered(body):
	if body.name == "Janek":
		$Label.show()
		interact = true

func _on_Area2D_body_exited(body):
	if body.name == "Janek":
		$Label.show()
		interact = false
		$Label.text = "interakcja (enter)"

func _input(event):
	if Input.is_action_just_pressed("ui_accept") and interact == true:
		$Label.text = "Chcesz odbudować komunizm?"