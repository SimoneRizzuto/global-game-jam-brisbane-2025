extends Node

@onready var oceanSound = $Ocean
@onready var surfaceMusic = $MusicBelowSurface

var index = 0
var playerPos = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	DepthManagement()
	

func DepthManagement():
	var index = playerPos / -16.0
	index = clampf(index,0.0,1.0)
	surfaceMusic.volume_db = lerpf(-50,0, index)
	oceanSound.volume_db = lerpf(0,-50, index)


func _on_ocean_finished():
	oceanSound.stream = load("res://Audio/Ocean (looping kinda).ogg")
	oceanSound.play()
