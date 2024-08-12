extends Node2D


func _process(delta):
	$Score.text = "Score: " + str(Global.points)
