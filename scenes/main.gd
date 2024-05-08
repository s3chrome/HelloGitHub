extends Node2D

const SPEED = 300.0

@onready var player := $Sprite2D
@onready var label := $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	JavaScriptBridge.eval("""
	document.documentElement.requestFullscreen();
	""")
	
	$Button.pressed.connect(my_func)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if dir:
		player.position += dir * SPEED * delta
		label.text = "%s" % player.position
	if Input.is_action_just_pressed("A"):
		label.text = "press a"
		
func my_func():
	#DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	JavaScriptBridge.eval("""
	document.exitFullscreen();
	""")

	#
	if OS.has_feature('web'):
		JavaScriptBridge.eval("""
			console.log('The JavaScriptBridge singleton is available')
		""")
	else:
		print("The JavaScriptBridge singleton is NOT available")

	#
	JavaScriptBridge.eval("alert('Calling JavaScript per GDScript!');")

	# number to float
	# boolean to bool
	# string to String
	# ArrayBuffer,TypedArray,DataView to PackedByteArray
	# other to null
	var js_return = JavaScriptBridge.eval("var myNumber = 1; myNumber + 2;")
	print(js_return) # prints '3.0'
	
	# execute in global execution context,
	# thus adding a new JavaScript global variable `SomeGlobal`
	JavaScriptBridge.eval("var SomeGlobal = {};", true)
