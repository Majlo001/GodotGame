extends Node2D

var score = 0

func _process(delta):
	pass


func _on_Coin_body_entered(body):
	if body is preload("res://Janek.gd"):
		score += 1
		print(score)
		var LabelNode = get_parent().get_node("UI/UI/Control/RichTextLabel")
		LabelNode.text = str(score)
