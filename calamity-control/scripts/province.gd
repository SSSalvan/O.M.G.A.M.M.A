extends Button
@onready var game_manager = get_node("/root/MainGameplay/GameManager")

@export var province_name: String = ""  # Name of the province
@export var development_level: int = 0  # Province-specific status

func _ready() -> void:
	set_process_input(true)
	province_name = name
	
func _on_pressed() -> void:
	show_development_prompt()
	
func show_development_prompt():
	var confirm_scene = load("res://scenes/develop_province.tscn").instantiate()
	get_tree().current_scene.add_child(confirm_scene)

	var popup = confirm_scene as DevelopProvince
	if popup:
		popup.game_manager = game_manager
		print("GameManager assigned in popup:", popup.game_manager)

		await get_tree().process_frame
		popup.position = get_viewport_rect().size * 0.5 + Vector2(-500, 0)

		# ✨ Generate random item requirements based on week
		var required_items = generate_required_items(game_manager.week)
		popup.set_title_text("Would you like to develop " + province_name + "?")
		popup.set_required_items(required_items)

		popup.confirmed.connect(self.increase_development)
	else:
		print("Failed to cast confirm_scene to DevelopProvince")

func increase_development():
	print("GameManager in popup:", game_manager)
	print("Current resources:", ResourceCount.resource)
	if ResourceCount.resource >= 400:
		ResourceCount.resource -= 400
		development_level += 1
		
		# Notify GameManager to update islands dictionary
		game_manager.increase_development(province_name, 0)
		
		game_manager.update_resource_label()
		print(province_name + " has been developed: ", development_level, " times")
	else:
		print("Not enough resources to develop!")

func generate_required_items(current_week: int) -> Dictionary:
	var required_items = {}
	var num_items = clamp(1 + int(current_week / 5), 1, 4)  # 1 item at start, up to 4

	while required_items.size() < num_items:
		var index = randi() % ShopItems.howManyItemsBro
		if !required_items.has(index):
			required_items[index] = randi_range(1, 3)  # Require 1–3 of that item
	return required_items
