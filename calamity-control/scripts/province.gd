extends Button
@onready var game_manager = get_node("/root/MainGameplay/GameManager")
@onready var shopPanel = get_node("/root/ShopPanel")
var FloatingText = preload("res://scenes/development_level_up.tscn")
@export var province_name: String = ""  # Name of the province
@export var development_level: int = 0  # Province-specific status
var cached_required_items: Dictionary = {}  # Stores required items for each province
var inventory: Dictionary = {} 

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

		# Check if required items are already cached for this province
		if not cached_required_items.has(province_name):
			var required_items = generate_required_items(game_manager.week)
			cached_required_items[province_name] = required_items
		else:
			print("Using cached required items for province:", province_name)

		# Set the title and required items in the popup
		popup.set_title_text("Would you like to develop " + province_name + "?")
		popup.set_required_items(cached_required_items[province_name])

		# Connect the confirmed signal
		popup.confirmed.connect(self.increase_development)
	else:
		print("Failed to cast confirm_scene to DevelopProvince")
		
func increase_development():
	print("Current inventory:", ShopItems.itemCount)  # Debug log

	# Check if cached required items exist for this province
	if not cached_required_items.has(province_name):
		print("Error: Required items not found for province:", province_name)
		return

	var required_items = cached_required_items[province_name]

	# Check if the player has enough items
	var has_enough_items = true
	for item_index in required_items.keys():
		var required_quantity = required_items[item_index]
		var current_quantity = ShopItems.get_item_count(item_index)

		print("Checking item index:", item_index, 
			  "Required:", required_quantity, 
			  "Have:", current_quantity)  # Debug log

		if current_quantity < required_quantity:
			has_enough_items = false
			print("Not enough of item ", ShopItems.get_item_name(item_index), 
				  " (Required: ", required_quantity, ", Have: ", current_quantity, ")")
			break

	if not has_enough_items:
		print("Development failed: Not enough items!")
		return

	# Deduct items from inventory
	for item_index in required_items.keys():
		var required_quantity = required_items[item_index]
		if not ShopItems.remove_item(item_index, required_quantity):
			print("Failed to deduct item ", ShopItems.get_item_name(item_index))
			return

	# Increase development level
	game_manager.increase_development(province_name, 1) # Pass the amount
	development_level = game_manager.get_development_level(province_name)
	shopPanel.refresh_item_labels()
	game_manager.update_resource_label()

	print(province_name + " has been developed: ", development_level, " times")
	print("Current inventory:", ShopItems.itemCount)

	var floating_text = FloatingText.instantiate()
	floating_text.global_position = global_position
	get_parent().add_child(floating_text)
	floating_text.set_text(province_name + "\nDev +1")


	# Clear cached required items for this province
	cached_required_items.erase(province_name)
	
func generate_required_items(current_week: int) -> Dictionary:
	var required_items = {}
	var num_items = clamp(1 + int(current_week / 5), 1, 4)  # 1 item at start, up to 4

	while required_items.size() < num_items:
		var index = randi() % ShopItems.howManyItemsBro
		if !required_items.has(index):
			required_items[index] = randi_range(1, 3)  # Require 1–3 of that item
	return required_items
