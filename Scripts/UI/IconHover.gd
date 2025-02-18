extends TextureRect

@export var nonIcon = true

@onready var img = $IconImg
@onready var UI = get_parent().get_parent().get_parent()
var MaxScale = 1.1
var minScale = 0.9

var hovered = false
var WiggleTime = 0

@export var type = "Null"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	#if WiggleTime > 0:
		#rotation = randf_range(-12,12)
		#WiggleTime -= delta
		#await get_tree().create_timer(0.1).timeout

func wiggle():
	WiggleTime = 0.5
	while (WiggleTime > 0):
		rotation_degrees = randf_range(-10,10)
		WiggleTime -= 0.1
		await get_tree().create_timer(0.05).timeout
	rotation_degrees = 0
	
func squash():
	img.scale = Vector2.ONE*minScale
	await get_tree().create_timer(0.05).timeout
	img.scale = Vector2.ONE

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and hovered:
				if nonIcon:
					wiggle()
				else:
					squash()
					if type == "Credits":
						get_parent().get_node("Credits").visible = true
					elif type == "Play":
						UI.get_parent().Unpause()
						Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
					elif type == "ScreenShot":
						ScreenShot()

func ScreenShot():
	UI.visible = false
	await get_tree().create_timer(0.05).timeout
	var image = get_viewport().get_texture().get_image()
	image.save_png("res://Screenshots/" + str(Time.get_ticks_msec()) + "_screenshot.png")
	UI.visible = true

func _on_selection_mouse_entered():
	if !hovered:
		hovered = true
		img.scale = Vector2.ONE*MaxScale

func _on_selection_mouse_exited():
	if hovered:
		hovered = false
		img.scale = Vector2.ONE
