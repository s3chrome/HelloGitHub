extends Node2D

const SPEED = 300.0

@onready var player := $Sprite2D
@onready var label := $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if dir:
		player.position += dir * SPEED * delta
		label.text = "%s" % player.position
	if Input.is_action_just_pressed("A"):
		label.text = "press a"
		
