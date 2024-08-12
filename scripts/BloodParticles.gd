extends CPUParticles2D




func _on_Blood_Freezer_timeout():
	set_process(false) # process functions doesn't work
	set_physics_process(false) # same
	set_process_input(false) #*
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	
	
