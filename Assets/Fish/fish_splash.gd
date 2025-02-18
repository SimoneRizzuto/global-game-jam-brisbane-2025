extends TextureRect

var FishNum = 8;
var Speed = 1000.0
# Called when the node enters the scene tree for the first time.
func _ready():
	Speed = Speed * randf_range(0.5, 1.5)
	if randf_range(0.0,1.0) > 0.5:
		scale.x = -1
	texture = load("res://Assets/Fish/Img/Fish ("+ str(randi_range(1,FishNum))+").png")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (position.y < -40000):
		queue_free()
	else:
		position.y -= Speed * delta
