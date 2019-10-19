extends Area2D

var interact = false
var vis1 = false
var vis2 = false


func _on_Area2D_body_entered(body):
	if body.name == "Janek":
		$Label.show()
		interact = true


func _on_Area2D_body_exited(body):
	if body.name == "Janek":
		$Label.hide()
		interact = false
		$Label.text = "interakcja (enter)"
		
		if vis1 == true:
			vis2 = true
			
		vis1 = true

func _input(_event):
	if Input.is_action_just_pressed("ui_accept") and interact == true:
		$Label.text = "Poruszaj się W A S D, a walcz SPACJĄ."
		
		if vis1 == true:
			$Label.text = "Poruszaj się W A S D, a walcz SPACJĄ."
			
			if vis2 == true:
				$Label.text = "Poruszaj się W A S D, a walcz SPACJĄ."
		
