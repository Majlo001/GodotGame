extends Node2D

var score = 0

func _process(delta):
<<<<<<< HEAD
	pass


func _on_Coin_body_entered(body):
	if body is preload("res://Janek.gd"):
		score += 1
		print(score)
		var LabelNode = get_parent().get_node("UI/UI/Control/RichTextLabel")
		LabelNode.text = str(score)
=======
	var LabelNode = get_node("UI/UI/Control/RichTextLabel")
	var scr = get_node("Janek").score
	while scr == score + 1:
		score += 1
		LabelNode.text = str(scr)
>>>>>>> master
