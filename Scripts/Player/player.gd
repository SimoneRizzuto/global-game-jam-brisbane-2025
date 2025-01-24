extends CharacterBody3D

var gravity = 0.05
var speed = 2
var jump_speed = 5
var mouse_sensitivity = 0.001

@onready var camera = $Camera3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = camera.global_transform.basis * Vector3(input.x, 0, input.y)
	velocity.x = movement_dir.x * speed
	velocity.y = (movement_dir.y * speed) -gravity * delta
	velocity.z = movement_dir.z * speed

	move_and_slide()
	#if global_position.x
	#if is_on_floor() and Input.is_action_just_pressed("jump"):
		#velocity.y = jump_speed


func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
