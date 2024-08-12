extends RigidBody2D

class_name pocaoClass

@onready var pocao = $"."
@onready var sprite_elemento = $sprite/sprite_elemento


var currentElemento = GameManager.define_elemento()
var load_particula = preload("res://scenes/particula_explosao.tscn")


func explosao():
	print("explodiu")
	await timer_selfdestruction()
	adiciona_particula()
	
func adiciona_particula():
	var particula = load_particula.instantiate()
	particula.emitting = true
	particula.position = global_position
	particula.self_modulate = currentElemento
	get_tree().current_scene.add_child(particula)
	queue_free()


func timer_selfdestruction():
	await get_tree().create_timer(1.0).timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	sprite_elemento.self_modulate = currentElemento
	apply_impulse(get_local_mouse_position()*2.5,get_local_mouse_position())
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_detec_body_entered(body):
	explosao()
