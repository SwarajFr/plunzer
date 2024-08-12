extends Node2D

var enemy_1 = preload("res://scenes/Enemy.tscn")
onready var enemy_Spawn_timer = $EnemySpawnTimer
onready var visibility_notifier = $VisibilityNotifier2D

var points_check = 200
var array_check = 0
var inc = 3
var music_bus = AudioServer.get_bus_index("World")
export(Array, PackedScene) var enemies 

func _ready():
	Global.node_creation_parent = self
	Global.points = 0
	visibility_notifier.connect("screen_entered", self, "show")
	visibility_notifier.connect("screen_exited", self, "hide")
	visible = false
	
func _exit_tree():
	Global.node_creation_parent = null

func _on_EnemySpawnTimer_timeout():
	var enemy_position = Vector2(rand_range(-160,670), rand_range(-90,390))
	
	while enemy_position.x < 640 and enemy_position.x > -80 and enemy_position.y < 360 and enemy_position.y < -45:
		enemy_position = Vector2(rand_range(-160,670), rand_range(-90,390))
	
	var enemy_num = round(rand_range(array_check, enemies.size()- inc))
	
	Global.instance_node(enemies[enemy_num], enemy_position, self)
	enemy_Spawn_timer.wait_time *= 0.99
	
func _process(delta):
	if points_check == Global.points:
		inc = 2
		points_check = 250
		array_check = 1
		enemy_Spawn_timer.set_wait_time(4)
	if points_check == Global.points:
		inc = 1
		array_check = 0
	
	if Global.points % 200 == 0:
	   enemy_Spawn_timer.set_wait_time(4)
	##############################################
	if Input.is_action_pressed("pause"):
		get_tree().paused = true
		$UI/PauseMenu/CanvasLayer/ColorRect.visible = true
		
	
func _on_Difficulty_timeout():
	if enemy_Spawn_timer.wait_time > 1:
		enemy_Spawn_timer.wait_time -= 0.1


func _on_ResumeButton_pressed():
	get_tree().paused = false
	$UI/PauseMenu/CanvasLayer/ColorRect.visible = false
	
	


func _on_MainMenuButton_pressed():
	get_tree().paused = false
	


func _on_SoundToggle_pressed():
	AudioServer.set_bus_mute(music_bus, not AudioServer.is_bus_mute(music_bus))
