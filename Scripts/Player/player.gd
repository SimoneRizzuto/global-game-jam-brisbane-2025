extends CharacterBody3D

@onready var gearbox = get_parent().get_parent().get_node("Gearbox")

#physics/movement variables
@export var speed = 0.65
var jump_speed = 5
var mouse_sensitivity = 0.001
var accel = 3.5
var friction = 0.95
var targetVel = Vector3.ZERO
var strafeMod = 0.3

#systems for managing dashing
var dashing = false
@export var dashSpeed = 1.0

#Systems for managing surfacing, including launching out of the water and bobbing on the surface
var gravity = 2
var fallSpeed = 2
var sinkSpeed = 0.2
var surfacePoint = 0.25
var bobPoint = -0.5
var surfaced = false

#camera Systems
@onready var cameraArm = $CameraArm
@onready var camera = $CameraArm/Camera3D
var bobTime = 0.0
var bobFrequency = 0.2
var bobAmplitude = 0.1
@export var baseFOV = 38.0
@export var maxFOV = 45.0
var FOVShift = 1.0

#oxygen Management
var oxygenDrain = 0.1
var oxygenRefil = 30
var dashOxygenDrain = 1

#increase speed by depth
var maximumDepthMod = 7.0;
var maximumDepth = 600.0;
var initialDash = 0.0
var initialSink = 0.0
var initialSpeed = 0.0

func _ready():
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	initialDash = dashSpeed
	initialSink = sinkSpeed
	initialSpeed = speed

func _physics_process(delta):
	if gearbox.paused:
		if Input.is_action_just_pressed("Pause"):
			gearbox.Unpause()
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			return
	
	elif Input.is_action_just_pressed("Pause"):
		gearbox.Pause()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		return
	
	depth_management()
	
	var propulsion = Input.get_vector("left", "right", "forward", "back")
	
	var movement_dir = cameraArm.global_transform.basis * Vector3(propulsion.x * strafeMod, 0, propulsion.y)
	
	var strafeVertical = Input.get_axis("down","up")
	movement_dir += Vector3(0, strafeVertical, 0)
	
	if Input.is_action_pressed("dash"):
		dashing = true
		movement_dir += cameraArm.global_transform.basis * Vector3(0, 0, -dashSpeed)
		gearbox.oxygen -= delta * oxygenDrain
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

func depth_management():
	var index = global_position.y / -maximumDepth
	index = clampf(index,0.0,1.0)
	dashSpeed = lerpf(initialDash,initialDash * maximumDepthMod, index)
	#sinkSpeed = lerpf(initialSink,initialSink * maximumDepthMod, index)
	speed = lerpf(initialSpeed,initialSpeed * maximumDepthMod, index)
	
	AudioManager.playerPos = global_position.y

#if above the water, fall back to the surface, and then bob up and down until you recieve new input
func surface_and_descent(delta):
	if global_position.y > surfacePoint:
		velocity.y = lerpf(velocity.y, -fallSpeed, gravity*delta)
		surfaced = true
	else:
		if abs(targetVel.y) != 0:
			velocity.y = lerpf(velocity.y, targetVel.y, accel*delta)
		else:
			if  global_position.y > bobPoint:
				velocity.y = lerpf(velocity.y, 0, friction*delta)
			else:
				velocity.y = lerpf(velocity.y, -sinkSpeed, friction*delta)
	
	
	if global_position.y < -surfacePoint:
		gearbox.oxygen -= delta * oxygenDrain
	else:
		gearbox.oxygen += delta * oxygenRefil
	
	gearbox.oxygen = clampf(gearbox.oxygen, 0,100);

func camera_bob(delta):
	bobTime += delta# * velocity.length()
	
	var pos := Vector3.ZERO
	pos.y = sin(bobTime * bobFrequency) * bobAmplitude
	pos.x = cos(bobTime * bobFrequency/2) * bobAmplitude
	
	#camera.position = pos
	
	#FOV
	if (dashing):
		camera.fov = lerp(camera.fov, maxFOV, FOVShift * delta)
	else:
		camera.fov = lerp(camera.fov, baseFOV, FOVShift * delta)

func _input(event):
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * mouse_sensitivity)
		cameraArm.rotate_x(-event.relative.y * mouse_sensitivity)
		cameraArm.rotation.x = clampf(cameraArm.rotation.x, -deg_to_rad(90), deg_to_rad(90))
