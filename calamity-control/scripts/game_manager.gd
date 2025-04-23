extends Node

@onready var week_counter: Label = $"Week Counter"
@onready var resource_counter: Label = $"Resource Counter"
@onready var game_manager = get_parent().get_parent()

var week: int = 1
var is_event_active: bool = false
const MAX_WEEKS: int = 10


var islands = {
	"Sumatra": { "development": 0, "emission": randi_range(5, 12), "population": 100 },
	"Kalimantan": { "development": 0, "emission": randi_range(5, 12), "population": 100 },
	"Papua": { "development": 0, "emission": randi_range(5, 12), "population": 100 },
	"Jawa": { "development": 0, "emission": randi_range(5, 12), "population": 100 },
	"Sulawesi": { "development": 0, "emission": randi_range(5, 12), "population": 100 }
}

var events = [
	{ "type": "negative", "name": "Pembakaran Bahan Bakar Fosil", "emission_increase": 5, "cost": 300 },
	{ "type": "negative", "name": "Penebangan Hutan", "emission_increase": 4, "cost": 250 },
	{ "type": "positive", "name": "Mengurangi Bahan Bakar Fosil", "resource_reward": 300, "emission_decrease": 5 },
	{ "type": "positive", "name": "Menghentikan Deforestasi", "resource_reward": 250, "emission_decrease": 3 },
	{ "type": "minigame1", "name": "Trash Catching", "resource_reward": 400, "emission_decrease": 5 },
	{ "type": "minigame2", "name": "Fire Extinguish", "resource_reward": 400, "emission_decrease": 5 }
]

func _ready():
	randomize()  
	ResourceCount.resource = 500
	update_week_label()
	update_resource_label()
	#get_tree().root.print_tree_pretty()

func _process(_delta: float) -> void:
	update_resource_label()

func trigger_random_events():
	for island_name in islands.keys():
		if is_event_active:
			print("Event masih aktif, skip trigger baru.")
			return  # Langsung keluar dari loop supaya tidak ada event baru

		if randi() % 4 == 0:
			var random_event = events[randi() % events.size()]
			show_event_popup(island_name, random_event)
			is_event_active = true  # Set aktif saat event ditrigger
			break  # Hanya satu event yang bisa aktif


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

	elif event_data["type"] == "minigame1":
		# MENANG MINIGAME
		ResourceCount.add_money(event_data["resource_reward"])
		islands[island_name]["emission"] -= event_data["emission_decrease"]
		print("Menang minigame di ", island_name, ": +%d resource, -%d emisi" % [
			event_data["resource_reward"],
			event_data["emission_decrease"]
		])
		
	elif event_data["type"] == "minigame2":
		# MENANG MINIGAME
		ResourceCount.add_money(event_data["resource_reward"])
		islands[island_name]["emission"] -= event_data["emission_decrease"]
		print("Menang minigame di ", island_name, ": +%d resource, -%d emisi" % [
			event_data["resource_reward"],
			event_data["emission_decrease"]
		])
	is_event_active = false  # Reset saat event selesai
	update_resource_label()

func on_event_negated(island_name: String, event_data: Dictionary):
	if event_data["type"] == "negative":
		islands[island_name]["emission"] += event_data["emission_increase"]
		print("Event NEGATIVE tidak dicegah, emisi naik di ", island_name)

	elif event_data["type"] == "minigame":
		# GAGAL MINIGAME, tidak dapat reward apa-apa
		print("Gagal minigame di ", island_name, ", tidak ada reward.")
	is_event_active = false  # Reset saat event selesai
	update_resource_label()



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

func next_week():
	print("============End Week ", week, " Report============")
	show_development_levels()
	trigger_random_events()
	if week < MAX_WEEKS:
		week += 1
		update_week_label()
	else:
		print("10 weeks completed. Checking final status report...")
		check_final_status()

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
	var province_node = get_tree().root.get_node("MainGameplay/" + province_name)
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
			var pop_loss = int(emission * 0.05)  # 5% of current emission as population loss (rounded)

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
