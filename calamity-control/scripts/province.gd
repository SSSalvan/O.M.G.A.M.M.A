extends Sprite2D
@onready var game_manager = get_parent()

@export var province_name: String = ""  # Name of the province
var development_level: int = 0  # Province-specific status

func _ready() -> void:
	set_process_input(true)
	province_name = name

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = to_local(get_global_mouse_position())  # Get global mouse position
		if get_rect().has_point(mouse_pos):  # Convert mouse position to local and check
			print(province_name, " Selected")
			show_development_prompt()

func show_development_prompt():
	var confirm_scene = load("res://scenes/develop_province.tscn").instantiate()
	var popup = confirm_scene.get_node("Action_Select") as DevelopProvince
	popup.confirmed.connect(self.increase_development)
	get_tree().current_scene.add_child(confirm_scene)
	confirm_scene.move_to_front()


func increase_development():
	if game_manager.resource >= 400:
		game_manager.resource -= 400
		development_level += 1
		game_manager.update_resource_label()
		print(province_name + " has been developed: ", development_level, " times")
	else:
		print("You broke AF Boy!") 
