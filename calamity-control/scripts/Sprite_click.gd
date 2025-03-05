extends Sprite2D

func _ready() -> void:
	set_process_input(true)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = get_global_mouse_position()  # Get global mouse position
		if get_rect().has_point(to_local(mouse_pos)):  # Convert mouse position to local and check
			print("Sumatra Selected")
			var confirm_scene = load("res://scenes/develop_province.tscn").instantiate()
			add_child(confirm_scene)
			
			confirm_scene.move_to_front()
			var control_node = confirm_scene.get_node("Action_Select")
			
