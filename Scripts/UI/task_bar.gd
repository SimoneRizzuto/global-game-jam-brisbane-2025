extends Control

var selected = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and selected and visible:
				get_tree().quit()

func _on_off_button_mouse_entered():
	if visible and !selected:
		selected = true
		$Control/Red.visible = true
		$Control/Green.visible = false


func _on_off_button_mouse_exited():
	if selected:
		selected = false
		$Control/Red.visible = false
		$Control/Green.visible = true
