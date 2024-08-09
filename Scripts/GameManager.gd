extends Node

enum elementoenum {FIRE, WATER, WEED}

@export var elemento : elementoenum
var currentElemento : elementoenum

@onready var area_2d = $Area2D
@onready var camera_2d = $Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#select element
	if Input.is_action_just_pressed("selectWepon1"):
		elemento = elementoenum.FIRE
		currentElemento = elemento
	elif Input.is_action_just_pressed("selectWeapon2"):
		elemento = elementoenum.WATER
		currentElemento = elemento
	elif Input.is_action_just_pressed("selectWeapon3"):
		elemento = elementoenum.WEED
		currentElemento = elemento


func define_elemento():
	match elemento:
		elementoenum.FIRE:
			currentElemento = elemento
			return Color(2, 0.270588, 0, 1)
		elementoenum.WATER:
			currentElemento = elemento
			return Color(0.254902, 0.411765, 1.882353, 1)
		elementoenum.WEED:
			currentElemento = elemento
			return Color(0, 1.980392, 0.603922, 1)




