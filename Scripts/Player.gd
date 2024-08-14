extends CharacterBody2D


const SPEED = 50.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var sprite = $sprite
@onready var cajado = $cajado
@onready var elemento_cajado = $cajado/elemento_cajado
@onready var player = $"."

var load_pocao = preload("res://scenes/pocao.tscn")
var item_pocao = PackedScene
@export var elemento: elementoenum

enum elementoenum {FIRE, WATER, WEED}


#handle state machine
var main_sm: LimboHSM

func _ready():
	iniciate_state_machine()
	elemento_cajado.self_modulate = GameManager.define_elemento()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("moveLeft", "moveRight")
	if direction >= 1 :
		velocity.x = direction * SPEED
	elif direction <=-1:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	flip_sprite(direction)
	move_and_slide()
	
	elemento_cajado.self_modulate = GameManager.define_elemento()
	

func _unhandled_input(event):
	if event.is_action_pressed("jump"):
		main_sm.dispatch(&"to_jump")
	elif event.is_action_pressed("useItem"):
		main_sm.dispatch(&"to_use_item")


func flip_sprite(direction):
	if direction >= 1 and get_local_mouse_position().x > 0:
		sprite.set_flip_h(false)
	elif direction <= -1 and get_local_mouse_position().x < 0:
		sprite.set_flip_h(true)
	elif direction >= 1 and get_local_mouse_position().x < 0:
		sprite.set_flip_h(true)
	elif direction <= -1 and get_local_mouse_position().x > 0:
		sprite.set_flip_h(false)
	elif get_local_mouse_position().x <0:
		sprite.set_flip_h(true)
	else:
		sprite.set_flip_h(false)

func iniciate_state_machine():
	main_sm = LimboHSM.new()
	add_child(main_sm)
	
	var idle_state = LimboState.new().named("idle").call_on_enter(idle_start).call_on_update(idle_update)
	var walk_state = LimboState.new().named("walk").call_on_enter(walk_start).call_on_update(walk_update)
	var use_item_state = LimboState.new().named("use_item").call_on_enter(use_item_start).call_on_update(use_item_update)
	var jump_state = LimboState.new().named("Jump").call_on_enter(jump_start).call_on_update(jump_update)
	
	main_sm.add_child(idle_state)
	main_sm.add_child(walk_state)
	main_sm.add_child(use_item_state)
	main_sm.add_child(jump_state)
	
	main_sm.initial_state = idle_state
	
	main_sm.add_transition(idle_state,walk_state,&"to_walk")
	main_sm.add_transition(main_sm.ANYSTATE,idle_state,&"all_to_idle")
	main_sm.add_transition(idle_state,jump_state,&"to_jump")
	main_sm.add_transition(walk_state,jump_state,&"to_jump")
	main_sm.add_transition(main_sm.ANYSTATE,use_item_state,&"to_use_item")
	
	main_sm.initialize(self)
	main_sm.set_active(true)

func idle_start():
	sprite.play("idle")

func idle_update(delta: float):
	if velocity.x != 0:
		main_sm.dispatch(&"to_walk")

func walk_start():
	sprite.play("walk")

func walk_update(delta: float):
	if velocity.x == 0:
		main_sm.dispatch(&"all_to_idle")

func use_item_start():
	atira_pocao()

func use_item_update(delta: float):
	if is_on_floor():
		main_sm.dispatch(&"all_to_idle")

func jump_start():
	# Handle jump.
	if is_on_floor():
		velocity.y = JUMP_VELOCITY

func jump_update(delta: float):
	if is_on_floor():
		main_sm.dispatch(&"all_to_idle")

func atira_pocao():
	item_pocao = load_pocao.instantiate()
	add_child(item_pocao)
	item_pocao.reparent(player.get_parent())
	item_pocao.position = position + Vector2(10,-10)
	print(item_pocao.position)

