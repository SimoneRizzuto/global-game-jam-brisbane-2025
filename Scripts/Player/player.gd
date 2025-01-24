extends CharacterBody3D

var gravity = 2
var speed = 2
var jump_speed = 5
var mouse_sensitivity = 0.001
var accel = 5

var targetVel = Vector3.ZERO

@onready var camera = $Camera3D

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	var input = Input.get_vector("left", "right", "forward", "back")
	var movement_dir = camera.global_transform.basis * Vector3(input.x, 0, input.y)
	
	targetVel.x = movement_dir.x * speed
	targetVel.y = (movement_dir.y * speed) 
	targetVel.z = movement_dir.z * speed
	
	if global_position.y > 0:
		targetVel.y = -gravity
	
	velocity.x = lerpf(velocity.x, targetVel.x, accel*delta)
	velocity.y = lerpf(velocity.y, targetVel.y, accel*delta)
	velocity.z = lerpf(velocity.z, targetVel.z, accel*delta)
	

	
	
	move_and_slide()
	

		
	#if is_on_floor() and Input.is_action_just_pressed("jump"):
		#velocity.y = jump_speed


func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
