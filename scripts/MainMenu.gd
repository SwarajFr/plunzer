extends Node2D

var InfoArr = ["Don't die quick, its easy LMAOO", "Kill de Bacteria", "You're a plunger lol", "Dream high, Score low, I mean-"]

onready var Inform = $Info2

func _ready():
	Inform.text = InfoArr[rand_range(0,len(InfoArr))]
