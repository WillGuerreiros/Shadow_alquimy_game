extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position = get_local_mouse_position()
	limites_camera()

func limites_camera():
	limit_right = get_parent().position.x+400
	limit_left = get_parent().position.x-400
	limit_bottom = get_parent().position.y+100
	limit_top = get_parent().position.y-200
	limit_smoothed = true
