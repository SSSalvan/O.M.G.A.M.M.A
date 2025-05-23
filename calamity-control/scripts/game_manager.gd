extends Node

@onready var week_counter: Label = $"Week Counter"
@onready var resource_counter: Label = $"Resource Counter"
@onready var game_manager = get_parent().get_parent()

var howmanyisland: int = 0
var cached_required_items: Dictionary = {}  # Stores required items for each province
var difficulty: String = "medium"
var week: int = 1
var is_event_active: bool = false
const MAX_WEEKS: int = 52

var current_session_start_time: float = 0.0
var current_session_playtime: float = 0.0
var total_playtime: float = 0.0
var games_won: int = 0
var games_lost: int = 0
var current_username: String = ""

var islands = {}

var events = [
	{ "type": "negative", "name": "Burning of Fossil Fuels", "emission_increase": 5, "cost": 300 },
	{ "type": "negative", "name": "Deforestation", "emission_increase": 4, "cost": 250 },
	{ "type": "positive", "name": "Reducing Fossil Fuel Usage", "resource_reward": 300, "emission_decrease": 5 },
	{ "type": "positive", "name": "Stopping Deforestation", "resource_reward": 250, "emission_decrease": 3 },
	{ "type": "minigame1", "name": "Trash Catching", "goal": "Catch all the trash before time runs out.",
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

	ShopItems.resetItemQuantity()
	UpgradeReq._init()

	islandSetup()
	ResourceCount.resource = 500
	update_week_label()
	update_resource_label()

	start_session_timer() # Start the timer when the game scene loads

func diffCheck():
	if difficulty == "easy":
		print("easy diff")
	elif difficulty == "medium":
		print("med diff")
	elif difficulty == "hard":
		print("hard diff")

func _process(_delta: float) -> void:
	update_resource_label()
	update_playtime()
	if not is_event_active and Input.is_action_just_pressed("ui_accept"):
		_on_end_week_pressed()


func trigger_random_events():
	for island_name in islands.keys():
		if is_event_active:
			print("Event masih aktif, skip trigger baru.")
			return  

		if islands[island_name]["population"] <= 0:
			continue  # Skip islands with no population

		if randi() % 4 == 0:
			var random_event = events[randi() % events.size()]
			show_event_popup(island_name, random_event)
			is_event_active = true  
			break  


func _on_difficulty_selected(selected_difficulty: String) -> void:
	difficulty = selected_difficulty
	print("Selected difficulty is: ", difficulty)

func islandSetup():
	var pop_base = 750
	var islandCount = 0;
	if difficulty == "easy":
		islandCount = 1
		howmanyisland = 5
	elif difficulty == "medium":
		pop_base = 1500
		islandCount = 2
		howmanyisland = 7
		$Bali.visible = true
		$Maluku.visible = true
	elif difficulty == "hard":
		pop_base = 2000
		islandCount = 3
		howmanyisland = 10
		$Bali.visible = true
		$Maluku.visible = true
		$NTB.visible = true
		$NTT.visible = true
		$"Maluku Utara".visible = true
	
	if (islandCount>=1):
		islands["Riau"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 0}
		islands["Kalimantan Barat"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 1}
		islands["Papua Pegunungan"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 2}
		islands["DKI Jakarta"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 3}
		islands["Sulawesi Tengah"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 4}
	if (islandCount>=2):
		islands["Bali"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 5}
		islands["Maluku"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 6}
	if (islandCount>=3):
		islands["Ntt"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 7}
		islands["Ntb"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 8}
		islands["Maluku Utara"]= { "development": 0, "emission": randi_range(5, 12), "population": pop_base + randi_range(0, 200),  "type": 9}
	
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
		islands[island_name]["emission"] = clamp(islands[island_name]["emission"], 0, 100)
		print("Positive event in ", island_name, ", gained resource: ", event_data["resource_reward"], ", emission now: ", islands[island_name]["emission"])

	elif event_data["type"] == "minigame1" or event_data["type"] == "minigame2":
		ResourceCount.add_money(event_data["resource_reward"])
		islands[island_name]["emission"] -= event_data["emission_decrease"]
		islands[island_name]["emission"] = clamp(islands[island_name]["emission"], 0, 100)
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
		islands[island_name]["emission"] = clamp(islands[island_name]["emission"], 0, 100)
		print("NEGATIVE event was not countered. Emission increased in ", island_name)

	elif event_data["type"] == "minigame1" or event_data["type"] == "minigame2":
		islands[island_name]["emission"] += event_data["emission_increase"]
		islands[island_name]["emission"] = clamp(islands[island_name]["emission"], 0, 100)
		print("Minigame FAIL in ", island_name, ": ", event_data["lose_desc"])
		print("+%d emission due to failure." % event_data["emission_increase"])

	is_event_active = false 
	update_resource_label()


func _on_show_islands_status_pressed() -> void:
	var status_panel = preload("res://scenes/island_status_panel.tscn").instantiate()
	add_child(status_panel)
	
	status_panel.populate(islands)
	
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
	var emission_threshold = 0
	var population_threshold = 0
	var game_won: bool = false # Add a variable to track win/loss

	match difficulty:
		"easy":
			emission_threshold = 80
			population_threshold = 3000
		"medium":
			emission_threshold = 60
			population_threshold = 7000
		"hard":
			emission_threshold = 40
			population_threshold = 9000

	if total_emission < emission_threshold and total_population > population_threshold:
		print("You Win!")
		game_won = true
		get_tree().change_scene_to_file("res://scenes/winning.tscn")
	else:
		print("You Lose!")
		game_won = false
		get_tree().change_scene_to_file("res://scenes/lose.tscn")

		end_game(game_won)
	
func _on_pause_button_pressed() -> void:
	var pause_scene = load("res://scenes/setting_menu.tscn").instantiate()
	add_child(pause_scene)

func weekly_income_resource():
	ResourceCount.add_money(500)


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
		var population = islands[island]["population"]
		if population <= 0:
			print(island, " has 0 population. Skipping development and events.")
			continue  # Skip if island is "dead"
		
		var dev_level = islands[island]["development"]
		var emission = islands[island]["emission"]
		var required_dev: int = 0

		# Calculate required development based on week intervals
		if week < 15:
			required_dev = randi_range(1, 2) 
		elif week < 30:
			required_dev = randi_range(3, 4) 
		elif week < 45:
			required_dev = randi_range(5, 6)
		else:
			required_dev = randi_range(5, 9)

		print(island, ": Checking development. Current: ", dev_level, ", Required: ", required_dev)

		if dev_level < required_dev:
			# Apply penalties if development is insufficient
			var emission_increase = randi_range(1, 4)
			var pop_loss = int(emission * 0.5)
			islands[island]["emission"] = clamp(emission + emission_increase, 0, 100)
			islands[island]["population"] = max(population - pop_loss, 0)
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

func set_current_user(username: String):
	current_username = username
	load_user_profile()
	start_session_timer()

func load_user_profile():
	if current_username == "":
		return

	var path = "res://User/users.json"
	if FileAccess.file_exists(path):
		var file = FileAccess.open(path, FileAccess.READ)
		var content = file.get_as_text()
		var parsed = JSON.parse_string(content)
		file.close()
		if parsed is Dictionary and parsed.has(current_username):
			var user_data = parsed[current_username]
			total_playtime = user_data.get("total_playtime", 0.0)
			games_won = user_data.get("games_won", 0)
			games_lost = user_data.get("games_lost", 0)
			print("Loaded user profile for:", current_username, "Playtime:", total_playtime, "Wins:", games_won, "Losses:", games_lost)
		else:
			print("User profile not found or invalid format for:", current_username)
	else:
		print("Warning: users.json not found.")

func save_user_profile():
	if current_username == "":
		return

	var path = "res://User/users.json"
	var file = FileAccess.open(path, FileAccess.READ_WRITE)
	var content = file.get_as_text()
	var users_data = JSON.parse_string(content)
	if not users_data is Dictionary:
		users_data = {}

	users_data[current_username] = {
		"total_playtime": total_playtime,
		"games_won": games_won,
		"games_lost": games_lost
	}

	file.seek(0) # Go to the beginning of the file
	file.store_string(JSON.stringify(users_data, "\t"))
	file.truncate(file.get_position()) # Remove any remaining old content
	file.close()
	print("Saved user profile for:", current_username, "Playtime:", total_playtime, "Wins:", games_won, "Losses:", games_lost)

func start_session_timer():
	current_session_start_time = Time.get_unix_time_from_system()
	current_session_playtime = 0.0
	print("Session timer started.")

func update_playtime():
	if current_session_start_time > 0:
		current_session_playtime = Time.get_unix_time_from_system() - current_session_start_time

func end_game(won: bool):
	update_playtime()
	if UserData.current_user != "":
		UserData.add_playtime(UserData.current_user, current_session_playtime)
		if won:
			UserData.add_win(UserData.current_user)
		else:
			UserData.add_loss(UserData.current_user)
	current_session_start_time = 0.0 # Reset session timer
	current_session_playtime = 0.0
	print("Game ended. Total playtime and win/loss updated.")
