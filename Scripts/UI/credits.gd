extends TextureRect

var selected = false


func _unhandled_input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed and selected and visible:
				visible = false

func _on_off_button_mouse_entered():
	if visible and !selected:
		selected = true



func _on_off_button_mouse_exited():
	if selected:
		selected = false
