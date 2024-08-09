extends CharacterBody2D

class_name enemy

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var typeElementEnemy = GameManager.elementoenum.FIRE

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	
	move_and_slide()



func move_inimigo(posicaoPocao : Vector2):
	move_and_collide(posicaoPocao)
	

func _on_area_2d_body_entered(body):
	print("detectou body entrou na area,tipo:  "+ str(body))
	if body.is_in_group("pocao"):
		if typeElementEnemy == 0 and body.currentElemento == Color(2, 0.270588, 0, 1) :
			print("sao mesmo elemento")
			move_inimigo(body.get_position())

