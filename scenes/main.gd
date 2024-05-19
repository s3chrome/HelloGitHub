extends Node2D
## Webエクスポートあれこれ

const SPEED = 300.0

@onready var player := $Sprite2D
@onready var label := $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.pressed.connect(toggleFullScreen)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var dir = Input.get_vector("LLeft", "LRight", "LUp", "LDown")
	if dir:
		player.position += dir * SPEED * delta
		label.text = "%s" % player.position
	if Input.is_action_just_pressed("A"):
		label.text = "press A"
	if Input.is_action_just_pressed("Start"):
		label.text = "press Start"
	if Input.is_action_just_pressed("Back"):
		label.text = "press Back"
	if Input.is_action_just_pressed("Home"):
		label.text = "press Home"

func toggleFullScreen():
	if OS.has_feature('web'):
		JavaScriptBridge.eval("""
		if(!document.fullscreenElement){
		document.documentElement.requestFullscreen();}
		else if(document.exitFullscreen){
		document.exitFullscreen();}
		""")
	else:
		if DisplayServer.window_get_mode() != DisplayServer.WINDOW_MODE_FULLSCREEN:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		else:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

	#
	#if OS.has_feature('web'):
		#JavaScriptBridge.eval("""
			#console.log('The JavaScriptBridge singleton is available')
		#""")
	#else:
		#print("The JavaScriptBridge singleton is NOT available")

	#
	#JavaScriptBridge.eval("alert('Calling JavaScript per GDScript!');")

	# number to float
	# boolean to bool
	# string to String
	# ArrayBuffer,TypedArray,DataView to PackedByteArray
	# other to null
	#var js_return = JavaScriptBridge.eval("var myNumber = 1; myNumber + 2;")
	#print(js_return) # prints '3.0'
	
	# execute in global execution context,
	# thus adding a new JavaScript global variable `SomeGlobal`
	#JavaScriptBridge.eval("var SomeGlobal = {};", true)
