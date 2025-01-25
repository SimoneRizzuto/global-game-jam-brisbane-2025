extends CharacterBody3D


#physics/movement variables
var speed = 0.7
var jump_speed = 5
var mouse_sensitivity = 0.001
var accel = 5
var friction = 0.95
var targetVel = Vector3.ZERO

#systems for managing dashing
var dashing = false
var dashSpeed = 3

#Systems for managing surfacing, including launching out of the water and bobbing on the surface
var gravity = 2
var fallSpeed = 2
var sinkSpeed = 0.2
var surfacePoint = 0.25
var bobPoint = -0.5

#camera Systems
@onready var cameraArm = $CameraArm
@onready var cameraSpring = $CameraArm/SpringArm3D
@onready var camera = $CameraArm/Camera3D
var bobTime = 0
var bobFrequency = 0.2
var bobAmplitude = 0.1

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(delta):
	var input = Input.get_vector("left", "right", "forward", "back")
	
	var movement_dir = cameraArm.global_transform.basis * Vector3(input.x, 0, input.y)
	
	if Input.is_action_pressed("dash"):
		dashing = true
		movement_dir += cameraArm.global_transform.basis * Vector3(0, 0, -dashSpeed)
	else:
		dashing = false
	
	#set the ttarget velocity to accelerate towards
	targetVel.x = movement_dir.x * speed
	targetVel.y = (movement_dir.y * speed) 
	targetVel.z = movement_dir.z * speed
	
	#handle surfacing and descent
	surface_and_descent(delta)
	
	#if not detecting movement input, use friction rather than accelaration
	if abs(targetVel.x) != 0:
		velocity.x = lerpf(velocity.x, targetVel.x, accel*delta)
	else:
		velocity.x = lerpf(velocity.x, 0, friction*delta)
	
	if abs(targetVel.z) != 0:
		velocity.z = lerpf(velocity.z, targetVel.z, accel*delta)
	else:
		velocity.z = lerpf(velocity.z, 0, friction*delta)
	
	
	
	move_and_slide()
	
	camera_bob(delta)

#if above the water, fall back to the surface, and then bob up and down until you recieve new input
func surface_and_descent(delta):
	if global_position.y > surfacePoint:
		velocity.y = lerpf(velocity.y, -fallSpeed, gravity*delta)
	else:
		if abs(targetVel.y) != 0:
			velocity.y = lerpf(velocity.y, targetVel.y, accel*delta)
		else:
			if  global_position.y > bobPoint:
				velocity.y = lerpf(velocity.y, 0, friction*delta)
			else:
				velocity.y = lerpf(velocity.y, -sinkSpeed, friction*delta)
	
	

func camera_bob(delta):
	bobTime += delta# * velocity.length()
	
	var pos := Vector3.ZERO
	pos.y = sin(bobTime * bobFrequency) * bobAmplitude
	pos.x = cos(bobTime * bobFrequency/2) * bobAmplitude
	
	camera.position = pos
	
	#FOV
	#var velocity_clamped = clamp(velocity.length(), 0.5, sprint_speed * 2)
	#var target_fov = base_FOV + FOV_change * velocity_clamped
	#cam.fov = lerp(cam.fov, target_fov, delta * 8.0)

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		cameraArm.rotate_x(-event.relative.y * mouse_sensitivity)
		#camera.rotation.x = clampf($Camera3D.rotation.x, -deg_to_rad(70), deg_to_rad(70))
