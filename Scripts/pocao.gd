extends RigidBody2D

class_name pocaoClass

enum elementoenum {FIRE, WATER, WEED}

@onready var pocao = $"."
@onready var sprite_elemento = $sprite/sprite_elemento

@export var elemento: elementoenum

var load_particula = preload("res://scenes/particula_explosao.tscn")


func explosao():
	print("explodiu")
	await timer_selfdestruction()
	adiciona_particula()
	
func adiciona_particula():
	var particula = load_particula.instantiate()
	particula.emitting = true
	particula.position = global_position
	particula.self_modulate = define_elemento()
	get_tree().current_scene.add_child(particula)
	queue_free()

func define_elemento():
	match elemento:
		elementoenum.FIRE:
			return Color(2, 0.270588, 0, 1)
		elementoenum.WATER:
			return Color(0.254902, 0.411765, 1.882353, 1)
		elementoenum.WEED:
			return Color(0, 1.980392, 0.603922, 1)

func timer_selfdestruction():
	await get_tree().create_timer(1.0).timeout


func elemento_pocao(): 
	var elemento_pocao = randi_range(0,2)
	match elemento_pocao:
		0:	elemento = elementoenum.FIRE
		1:	elemento = elementoenum.WATER
		2:	elemento = elementoenum.WEED
# Called when the node enters the scene tree for the first time.
func _ready():
	elemento_pocao()
	sprite_elemento.self_modulate = define_elemento()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_detec_body_entered(body):
	explosao()
