extends Control

@onready var label = $TextContainer/RichTextLabel
@onready var anim = $AnimationPlayer
var messageShown = false
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("CloseMessage") and messageShown:
		messageShown = false
		anim.play("SlideOutOfDms")

func newMessage(message, imagePath):
	print(message)
	label.text = message
	anim.play("SlideIntoDms")
	messageShown = true
	
