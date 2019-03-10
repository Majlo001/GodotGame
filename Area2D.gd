extends Area2D

var taken=false

func _on_coin_body_enter( body ):
	if not taken and body is preload("res://KinematicBody2D.gd"):
		taken = true
		print("coin")
		