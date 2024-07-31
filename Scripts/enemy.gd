extends CharacterBody2D

class_name enemy

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var typeElementenemy = GameManager.elementoenum.FIRE

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if typeElementenemy == 0:
		velocity.x += 10
