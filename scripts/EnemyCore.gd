extends Sprite

export(int) var speed = 50
export(int) var knockback = 15
export(int) var hp = 30
export(int) var screenshake = 100
export(int) var points_increment = 10

var velocity = Vector2()

var stun = false

onready var current_color = modulate

var blood_particles = preload("res://scenes/BloodParticles.tscn")

func _process(delta):
	if hp <= 0:
		if Global.camera != null:
			Global.camera.screen_shake(screenshake, 0.1)

		Global.points += points_increment
		if Global.node_creation_parent != null:
			var blood_paricles_instance = Global.instance_node(blood_particles, global_position, Global.node_creation_parent)
			blood_paricles_instance.rotation = velocity.angle()
		queue_free()

func _basic_movement(delta):
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)

	global_position += velocity * speed * delta
	velocity = velocity.normalized()
	
func _on_EnemyHitbox_area_entered(area):
	if area.is_in_group("Enemy_Damager") and stun == false:
		$Stun_Timer.start()
		velocity = -velocity * knockback
		hp -= 10
		stun = true
		area.get_parent().queue_free()
	
func _on_Stun_Timer_timeout():
	stun = false
