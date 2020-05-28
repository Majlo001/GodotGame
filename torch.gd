extends Node2D


func _ready():
	pass # Replace with function body.


func _on_Timer_timeout():
	$Tween.interpolate_property($Light2D, "energy", $Light2D.energy, rand_range(0.95, 1.05), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	
	$Tween.start()
