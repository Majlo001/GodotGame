extends Node2D

var score = 0

func _process(delta):
	var LabelNode = get_node("UI/UI/Control/RichTextLabel")
	var scr = get_node("Janek").score
	while scr == score + 1:
		score += 1
		LabelNode.text = str(scr)