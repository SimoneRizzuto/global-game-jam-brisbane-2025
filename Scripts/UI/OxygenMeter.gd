extends Label
@onready var gearbox = get_parent().get_parent().get_parent().get_parent().get_node("Gearbox")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = str(snapped(gearbox.oxygen,0.1)) + "%"
