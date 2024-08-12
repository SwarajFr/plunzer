extends KinematicBody2D

export var speed = 200

var velocity = Vector2()

var bullet = preload("res://scenes/Bullet.tscn")

# var is_dead = false
var can_shoot = true

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null
	

func get_input():
	look_at(get_global_mouse_position()) 
	velocity.x = int(Input.is_action_pressed("move_right")) - int(Input.is_action_pressed("move_left"))
	velocity.y = int(Input.is_action_pressed("move_down")) - int(Input.is_action_pressed("move_up"))

	
	
func _physics_process(delta):
	get_input()
	
	velocity = velocity.normalized()
	
	global_position.x = clamp(global_position.x, 0 ,640)
	global_position.y = clamp(global_position.y, 0 ,360)
	
	# if is_dead == false:
	global_position +=  speed * velocity * delta
		
	#velocity = move_and_slide(velocity)
	if Input.is_action_pressed("shoot") and Global.node_creation_parent != null and can_shoot: #  and is_dead == false
		Global.instance_node(bullet, global_position, Global.node_creation_parent)
		$ReloadSpeed.start()
		can_shoot = false

func _on_Timer_timeout():
	can_shoot = true
	$AnimatedSprite.play("idle")
	
	
func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		# is_dead = true
		Global.save_game()
		visible = false
		yield(get_tree().create_timer(0.5), "timeout")
		set_process(false)
		get_tree().current_scene.pause_mode = true
		get_tree().change_scene("res://UI/GameOver.tscn")
		


