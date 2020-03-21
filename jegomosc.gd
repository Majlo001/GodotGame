extends Area2D
onready var dialogue = get_node('../Dialogue/Dialogue')
onready var Janek = get_parent().get_node('Janek')

var interact = false
var vis1 = false
var vis2 = false
var conversation = false


func _on_Jegomosc_body_entered(body):
	if body.name == "Janek":
		$Label.show()
		interact = true


func _on_Jegomosc_body_exited(body):
	if body.name == "Janek":
		$Label.hide()
		interact = false
		$Label.text = "interakcja (enter)"
		
		if vis1 == true:
			vis2 = true
			
		vis1 = true

func _input(_event):
	if Input.is_action_just_pressed("ui_accept") and interact == true and conversation == false:
		get_parent().get_node("Dialogue/Dialogue").show()
		conversation = true
		$Label.hide()
		init_a()

func init_a():
	dialogue.initial('text_conversation')
