extends CharacterBody2D

class_name enemy

const SPEED = 200
const JUMP_VELOCITY = -10

var target = null
@export var typeElementEnemy = GameManager.elementoenum.FIRE

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")/10


func _physics_process(delta):
	move_and_slide()
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
		move_and_slide()
	if target:
		segue_target(target,delta)

func segue_target(target, delta):
	var velocity = global_position.direction_to(target.global_position)
	move_and_collide(velocity * SPEED * delta)


func _on_area_2d_body_entered(body):
	print("detectou body entrou na area,tipo:  "+ str(body))
	if body.is_in_group("pocao"):
		if typeElementEnemy == 0 and body.currentElemento == GameManager.red :
			print("sao mesmo elemento")
			target = body



func _on_area_2d_body_exited(body):
	target = null

