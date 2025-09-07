extends Camera3D



## Exported Variables
#(float, 0.0, 100.0)
@export var speed := 12.0

#(float, 1.0, 10.0)
@export var boost := 2.25

#(float, 0.0, 10.0)
@export var camera_sensitivity := 5.0



## Built-In Virtual Methods
func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func _process(delta : float):
	var direction := Vector3()
	if Input.is_action_pressed("ui_up"):
		direction += Vector3.FORWARD
	if Input.is_action_pressed("ui_down"):
		direction += Vector3.BACK
	if Input.is_action_pressed("ui_right"):
		direction += Vector3.RIGHT
	if Input.is_action_pressed("ui_left"):
		direction += Vector3.LEFT
	
	translate(
			direction * speed * 
			(boost if Input.is_key_pressed(KEY_SHIFT) else 1) * delta)


func _unhandled_input(event : InputEvent):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() != Input.MOUSE_MODE_CAPTURED:
			return
		
		var movement : Vector2 = event.relative.normalized()
		rotation_degrees.x += -movement.y * camera_sensitivity
		rotation_degrees.y += -movement.x * camera_sensitivity
	elif event is InputEventKey:
		if event.keycode == KEY_ESCAPE and not event.is_pressed():
			Input.set_mouse_mode(
					Input.MOUSE_MODE_CAPTURED
					if Input.get_mouse_mode() == Input.MOUSE_MODE_VISIBLE
					else Input.MOUSE_MODE_VISIBLE)
