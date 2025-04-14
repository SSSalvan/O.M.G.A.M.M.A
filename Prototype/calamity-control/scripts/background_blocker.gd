extends ColorRect

func _ready() -> void:
	self.mouse_filter = Control.MOUSE_FILTER_STOP
	#print("BackgroundBlocker is active!")
	self.visible = true

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton or event is InputEventMouseMotion:
		accept_event()  # Block input from propagating
		#print("Background blocked input: ", event)
