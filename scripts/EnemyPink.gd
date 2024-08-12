extends "res://scripts/EnemyCore.gd"

func _process(delta):
	_basic_movement(delta)
	#blood_particles.modulate = Color(255, 182, 193, 1)
