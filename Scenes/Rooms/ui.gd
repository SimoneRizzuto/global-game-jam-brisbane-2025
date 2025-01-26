extends Control

@onready var messageDisplay = $Message

@onready var anim = $AnimationPlayer
var justStarted = true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func Get_Message(message, imagePath):
	messageDisplay.newMessage(message, imagePath)

func Pause(start = false):
	anim.play("OpenMenu")
	if (start):
		justStarted = true

func UnPause():
	anim.play("CloseMenu")
	if (justStarted):
		AudioManager.oceanSound.play()
		AudioManager.surfaceMusic.play()
		justStarted = true
