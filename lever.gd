extends Area2D

var interact = false

func _on_lever_body_entered(body):
	if body.name == "Janek":
		interact = true

func _on_lever_body_exited(body):
	if body.name == "Janek":
		interact = false

func _input(_event):
	if Input.is_action_just_pressed("ui_e") and interact == true:
		var lever_off = get_parent().get_node("lever/lever_off")
		var lever_on = get_parent().get_node("lever/lever_on")
		var wall = get_parent().get_node("wall")
		lever_off.hide()
		lever_on.show()
		wall.position = Vector2(0,-140)

