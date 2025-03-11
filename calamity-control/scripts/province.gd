extends Sprite2D
@onready var game_manager = get_node("/root/MainGameplay/GameManager")

@export var province_name: String = ""  # Name of the province
var development_level: int = 0  # Province-specific status

func _ready() -> void:
	set_process_input(true)
	province_name = name

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and not event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var mouse_pos = to_local(get_global_mouse_position())  # Get global mouse position
		if get_rect().has_point(mouse_pos):  # Convert mouse position to local and check
			print(province_name, " Selected")
			show_development_prompt()

func show_development_prompt():
	var confirm_scene = load("res://scenes/develop_province.tscn").instantiate()
	get_tree().current_scene.add_child(confirm_scene)
	
	var popup = confirm_scene as DevelopProvince
	if popup:
		popup.game_manager = get_tree().root.get_node("MainGameplay/GameManager")
		print("GameManager assigned in popup:", popup.game_manager)
		
		await get_tree().process_frame
		popup.set_title_text("Would you like to develop " + province_name + "? (400)")
		popup.position = get_viewport_rect().size * 0.5 + Vector2(-500, 0)
		
		popup.confirmed.connect(self.increase_development)
	else:
		print("Failed to cast confirm_scene to DevelopProvince")

func increase_development():
	print("GameManager in popup:", game_manager)
	print("Current resources:", game_manager.resource)
	if game_manager.resource >= 400:
		game_manager.resource -= 400
		development_level += 1
		game_manager.update_resource_label()
		print(province_name + " has been developed: ", development_level, " times")
	else:
		print("You broke AF Boy!")
