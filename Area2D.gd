extends Area2D

var taken = false

func _on_Area2D_body_enter(body):
	if body.name == "Janek":
		if not taken and body is preload("res://KinematicBody2D.gd"):
			taken = true
			print("coin")