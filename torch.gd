extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	$Tween.interpolate_property($Light2D, "energy", $Light2D.energy, rand_range(0.95, 1.05), 0.1, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	
	$Tween.start()
