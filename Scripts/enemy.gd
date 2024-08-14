extends CharacterBody2D

class_name enemy

const SPEED = 200
const JUMP_VELOCITY = -10


@onready var animated_sprite_2d = $AnimatedSprite2D
  

var targetPocaoFollow := false
var targetPocaoRun := false
var targetChange := false
var target := RigidBody2D
var ultimaposicao : Vector2
@export var typeElementEnemy: GameManager.elementoenum

signal troca_position

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")/10

func _ready():
	animated_sprite_2d.self_modulate = define_elemento()

func _physics_process(delta):
	move_and_slide()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		move_and_slide()
	if targetPocaoFollow == true:
		segue_target(target,delta)
	if targetPocaoRun == true:
		run_from_target(target,delta)
	if targetChange == true:
		change_position_target(target)

func change_position_target(target):
	targetChange = false
	ultimaposicao = position
	position = get_tree().get_nodes_in_group("player")[0].position
	get_tree().get_nodes_in_group("player")[0].position = ultimaposicao
	

func run_from_target(target,delta):
	var velocity = -global_position.direction_to(target.global_position)
	move_and_collide(velocity * SPEED * delta)
	print(str(velocity))

func segue_target(target,delta):
	var velocity = global_position.direction_to(target.global_position)
	move_and_collide(velocity * SPEED * delta)
	

func verifica_elemento(body):
	if typeElementEnemy == GameManager.elementoenum.FIRE and body.currentElemento == GameManager.red :
		print("sao mesmo elemento fogo/fogo")
		targetPocaoFollow = true
		target = body
	elif typeElementEnemy == GameManager.elementoenum.FIRE and body.currentElemento == GameManager.blue:
		print("nao sao mesmo elemento fogo/agua")
		targetPocaoRun = true
		target = body
	elif typeElementEnemy == GameManager.elementoenum.WATER and body.currentElemento == GameManager.blue :
		print("sao mesmo elemento agua/agua")
		targetPocaoFollow = true
		target = body
	elif typeElementEnemy == GameManager.elementoenum.WATER and body.currentElemento == GameManager.red:
		print("nao sao mesmo elemento agua/fogo")
		targetPocaoRun = true
		target = body
	elif typeElementEnemy == GameManager.elementoenum.WEED and body.currentElemento == GameManager.weed :
		print("sao mesmo elemento weed/weed")
		targetChange = true
		target = body

func _on_area_2d_body_entered(body):
	print("detectou body entrou na area,tipo:  "+ str(body))
	if body.is_in_group("pocao"):
		verifica_elemento(body)



func _on_area_2d_body_exited(body):
	targetPocaoFollow = false
	targetPocaoRun = false
	targetChange = false

func define_elemento():
	match typeElementEnemy:
		GameManager.elementoenum.FIRE:
			return GameManager.red
		GameManager.elementoenum.WATER:
			return GameManager.blue
		GameManager.elementoenum.WEED:
			return GameManager.weed

