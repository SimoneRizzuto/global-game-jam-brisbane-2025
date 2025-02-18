extends Control

@onready var fish = preload("res://Assets/Fish/fish_splash.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func CallFish():
	var instance = fish.instantiate()
	add_child(instance)
	instance.global_position = global_position
	instance.global_position.x += randf_range(-1000.0,1000.0)
