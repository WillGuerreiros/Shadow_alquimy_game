extends CharacterBody2D

class_name enemy

const SPEED = 100.0
const JUMP_VELOCITY = -400.0

var target = null
@export var typeElementEnemy = GameManager.elementoenum.FIRE

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity/100 * delta
		move_and_slide()
	if target:
		var velocity = global_position.direction_to(target.global_position)
		move_and_collide(velocity * SPEED * delta)
	move_and_slide()


func _on_area_2d_body_entered(body):
	print("detectou body entrou na area,tipo:  "+ str(body))
	if body.is_in_group("pocao"):
		if typeElementEnemy == 0 and body.currentElemento == Color(2, 0.270588, 0, 1) :
			print("sao mesmo elemento")
			target = body



func _on_area_2d_body_exited(body):
	target = null

