extends Node3D

@onready var area = get_parent().get_node("Area3D")
@onready var mesh = get_parent().get_node("MeshInstance3D")


var player
# Called when the node enters the scene tree for the first time.
func _ready():
	$Label.text = get_parent().Message


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible:
		rotation = get_viewport().get_camera_3d().global_rotation
		rotate_object_local(Vector3.UP,3.14159)


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		#visible = true
		area.visible = false
		mesh.visible = false
		player = body
		
		
