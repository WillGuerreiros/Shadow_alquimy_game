extends Node

class_name gamemanagerclass

enum elementoenum {FIRE, WATER, WEED}

@export var elemento : elementoenum
var currentElemento : elementoenum
var posicaoPlayer = null



const red = Color(2, 0.270588, 0, 1)
const blue = Color(0.254902, 0.411765, 1.882353, 1)
const weed = Color(0, 1.980392, 0.603922, 1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
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
			return red
		elementoenum.WATER:
			currentElemento = elemento
			return blue
		elementoenum.WEED:
			currentElemento = elemento
			return weed


