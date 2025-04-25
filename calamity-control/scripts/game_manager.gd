extends Node

@onready var week_counter: Label = $"Week Counter"
@onready var resource_counter: Label = $"Resource Counter"
@onready var game_manager = get_parent().get_parent()

var difficulty: String = "medium"
var week: int = 1
var is_event_active: bool = false
const MAX_WEEKS: int = 52


var islands = {}

var events = [
	{ "type": "negative", "name": "Burning of Fossil Fuels", "emission_increase": 5, "cost": 300 },
	{ "type": "negative", "name": "Deforestation", "emission_increase": 4, "cost": 250 },
	{ "type": "positive", "name": "Reducing Fossil Fuel Usage", "resource_reward": 300, "emission_decrease": 5 },
	{ "type": "positive", "name": "Stopping Deforestation", "resource_reward": 250, "emission_decrease": 3 },
	{ "type": "minigame1", "name": "Trash Catching", "goal": "Catch all the trash floating in the water before time runs out.",
		"resource_reward": 400, "emission_decrease": 5, 
		"win_desc": "You've cleaned the water successfully! Marine life thrives again.",
		"lose_desc": "Too much trash was left behind. Pollution levels rise...", "emission_increase": 3
	},
	{ "type": "minigame2", "name": "Fire Extinguish", "goal": "Put out all the forest fires before they spread too far.",
		"resource_reward": 400, "emission_decrease": 5, 
		"win_desc": "Great job! The forest is safe and healthy once again.",
		"lose_desc": "The fire spread too far... parts of the forest were lost.", "emission_increase": 3
	}
]

func _ready():
	randomize() 
	difficulty = GameDifficulty.diff
	diffCheck()
	
	islandSetup()
	ResourceCount.resource = 500
	update_week_label()
	update_resource_label()

func diffCheck():
	if difficulty == "easy":
		print("easy diff")
	elif difficulty == "medium":
		print("med diff")
	elif difficulty == "hard":
		print("hard diff")

func _process(_delta: float) -> void:
	update_resource_label()

func trigger_random_events():
	for island_name in islands.keys():
		if is_event_active:
			print("Event masih aktif, skip trigger baru.")
			return  

		if randi() % 4 == 0:
			var random_event = events[randi() % events.size()]
			show_event_popup(island_name, random_event)
			is_event_active = true  
			break  

func _on_difficulty_selected(selected_difficulty: String) -> void:
	difficulty = selected_difficulty
	print("Selected difficulty is: ", difficulty)

func islandSetup():
	var islandCount = 0;
	if difficulty == "easy":
		islandCount = 1
	elif difficulty == "medium":
		islandCount = 2
		$Bali.visible = true
		$Maluku.visible = true
	elif difficulty == "hard":
		islandCount = 3
		$NTB.visible = true
		$NTT.visible = true
		$"Maluku Utara".visible = true
	
	if (islandCount>=1):
		islands["Sumatra"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
		islands["Kalimantan"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
		islands["Papua"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
		islands["Jawa"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
		islands["Sulawesi"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
	if (islandCount>=2):
		islands["Bali"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
		islands["Maluku"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
	if (islandCount>=3):
		islands["Ntt"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
		islands["Ntb"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
		islands["Maluku Utara"]= { "development": 0, "emission": randi_range(5, 12), "population": 100 }
	
func show_event_popup(island_name: String, event_data: Dictionary):
	if is_event_active:
		print("Event sedang aktif, tidak bisa munculkan event baru.")
		return

	var popup = load("res://scenes/event_notification.tscn").instantiate()
	add_child(popup)
	popup.set_event_data(island_name, event_data)
	popup.event_confirmed.connect(self.on_event_confirmed)
	popup.event_negated.connect(self.on_event_negated)

	is_event_active = true  
	print("Event aktif: ", event_data["name"])


func on_event_confirmed(island_name: String, event_data: Dictionary):
	if event_data["type"] == "negative":
		ResourceCount.subtract_money(event_data["cost"])
		print(island_name, " successfully negate ", event_data["name"], ", emission does not increase")

	elif event_data["type"] == "positive":
		ResourceCount.add_money(event_data["resource_reward"])
		islands[island_name]["emission"] -= event_data["emission_decrease"]
		print("Positive event in ", island_name, ", gained resource: ", event_data["resource_reward"], ", emission now: ", islands[island_name]["emission"])

	elif event_data["type"] == "minigame1" or event_data["type"] == "minigame2":
		# Assume player won the minigame (if there's a system to decide this dynamically, you can adjust)
		ResourceCount.add_money(event_data["resource_reward"])
		islands[island_name]["emission"] -= event_data["emission_decrease"]
		print("Minigame WIN in ", island_name, ": ", event_data["win_desc"])
		print("+%d resource, -%d emission" % [
			event_data["resource_reward"],
			event_data["emission_decrease"]
		])
		
	is_event_active = false 
	update_resource_label()

func on_event_negated(island_name: String, event_data: Dictionary):
	if event_data["type"] == "negative":
		islands[island_name]["emission"] += event_data["emission_increase"]
		print("NEGATIVE event was not countered. Emission increased in ", island_name)

	elif event_data["type"] == "minigame1" or event_data["type"] == "minigame2":
		islands[island_name]["emission"] += event_data["emission_increase"]
		print("Minigame FAIL in ", island_name, ": ", event_data["lose_desc"])
		print("+%d emission due to failure." % event_data["emission_increase"])
		
	is_event_active = false 
	update_resource_label()

func _on_show_islands_status_pressed() -> void:
	var new_panel = preload("res://scenes/island_status_panel.tscn").instantiate()
	add_child(new_panel)
	
	new_panel.populate(islands)
	
func _on_end_week_pressed() -> void:
	var confirm_scene = load("res://scenes/week_end_confirmation.tscn").instantiate()
	add_child(confirm_scene)
	confirm_scene.move_to_front()
	if week >= MAX_WEEKS:
		print("No more weeks left. Game already completed.")
		check_final_status()
		return
	else:
		var control_node = confirm_scene.get_node("Confirm_Week")
		if control_node and control_node.has_signal("confirmed"):
			print("Signal found!")  
			control_node.confirmed.connect(self.next_week)
			control_node.confirmed.connect(self.weekly_income_resource)
			control_node.confirmed.connect(self.check_development_requirements)
		else:
			print("ERROR: Signal 'confirmed' not found!") 
		print("Button Pressed")
		
func show_weekly_report():
	var report_scene = load("res://scenes/weekly_report.tscn").instantiate()
	add_child(report_scene)
	var required_dev = randi_range(1, 3)
	report_scene.set_report(week, islands, required_dev)
	report_scene.report_closed.connect(self._on_report_closed)
	
func next_week():
	print("============End Week ", week, " Report============")
	show_development_levels()
	if week < MAX_WEEKS:
		show_weekly_report()
	else:
		print("10 weeks completed. Checking final status report...")
		check_final_status()

func _on_report_closed():
	week += 1
	update_week_label()
	trigger_random_events()

func check_final_status():
	print("===== FINAL STATUS REPORT =====")
	
	var total_emission := 0
	var total_population := 0
	var all_dev_sufficient := true

	for island in islands.keys():
		var data = islands[island]
		var dev = data["development"]
		var emission = data["emission"]
		var pop = data["population"]

		total_emission += emission
		total_population += pop

		print(island + ": Development = " + str(dev) +
			  ", Emission = " + str(emission) +
			  ", Population = " + str(pop))

	# --- WIN / LOSE CONDITIONS ---
	if total_emission < 30 and total_population > 80:
		print("You Win!")
		get_tree().change_scene_to_file("res://scenes/winning.tscn")
	else:
		print("You Lose!")
		get_tree().change_scene_to_file("res://scenes/lose.tscn")



func weekly_income_resource():
	ResourceCount.add_money(500)
	update_resource_label()

func update_week_label():
	week_counter.text = "Week: " + str(week)
	#print("Week Updated, Week: ", week)

func update_resource_label():
	resource_counter.text = "Resource: " + str(ResourceCount.resource)

# Function to dynamically update development level
func increase_development(province_name: String, amount: int):
	var province_node = get_tree().root.get_node("MainGameplay/GameManager/" + province_name)
	if province_node:
		province_node.development_level += amount
		islands[province_name]["development"] = province_node.development_level
		print(province_name, " Development Increased to: ", islands[province_name]["development"])
	else:
		print("ERROR: Province node not found!")
	

func check_development_requirements():
	for island in islands.keys():
		var dev_level = islands[island]["development"]
		@warning_ignore("unused_variable")
		var emission = islands[island]["emission"]
		@warning_ignore("unused_variable")
		var population = islands[island]["population"]
		var required_dev: int = 0
		
		if week < 3:
			required_dev = 0
			print("No development is required")
		else:
			required_dev = randi_range(1, 3)
			

		if dev_level < required_dev:
			var emission_increase = randi_range(1, 4)
			var pop_loss = int(emission * 0.5)  

			islands[island]["emission"] += emission_increase
			islands[island]["population"] -= pop_loss

			print(island, " development too low! Required: ", required_dev)
			print("Emission increased by ", emission_increase, " to ", islands[island]["emission"])
			print("Population decreased by ", pop_loss, " to ", islands[island]["population"])
		else:
			print(island, " is developing well. No penalty this week (Required: ", required_dev, ")")

func get_development_level(province_name: String) -> int:
	var province_node = get_tree().root.get_node("MainGameplay/GameManager/" + province_name)
	if province_node:
		return province_node.development_level
	print("ERROR: Province node not found!")
	return -1

func show_development_levels():
	print("Development Levels at the end of Week ", week, ":")
	for province_name in islands.keys():
		var province_node = get_tree().root.get_node("MainGameplay/GameManager/" + province_name)
		if province_node:
			var dev_level = province_node.development_level
			islands[province_name]["development"] = dev_level
			print(province_name, " - Development Level: ", dev_level)
		else:
			print("ERROR: Province node for ", province_name, " not found!")

func generate_item_requirements(week: int) -> Dictionary:
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var item_requirements = {}
	var difficulty = clamp(week / 5, 1, 4)
	var num_items = rng.randi_range(1, 2 + difficulty)
	var used_indices = []
	
	while item_requirements.size() < num_items:
		var index = rng.randi_range(0, ShopItems.howManyItemsBro - 1)
		if index in used_indices:
			continue
		used_indices.append(index)
		var item_name = ShopItems.itemName[index]
		var item_amount = rng.randi_range(1, difficulty + 1)
		item_requirements[item_name] = item_amount
	
	return item_requirements
