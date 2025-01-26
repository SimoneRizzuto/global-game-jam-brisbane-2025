extends TextureRect

@export var nonIcon = true

@onready var img = $IconImg

var MaxScale = 1.1

var hovered = false
var WiggleTime = 0

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

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and hovered:
				print ()
				if nonIcon:
					wiggle()

func _on_selection_mouse_entered():
	if !hovered:
		hovered = true
		img.scale = Vector2.ONE*MaxScale

func _on_selection_mouse_exited():
	if hovered:
		hovered = false
		img.scale = Vector2.ONE