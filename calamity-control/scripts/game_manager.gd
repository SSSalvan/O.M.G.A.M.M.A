extends Node

@onready var week_counter: Label = $"Week Counter"
@onready var resource_counter: Label = $"Resource Counter"
@onready var game_manager = get_parent().get_parent()

var week: int = 1
const MAX_WEEKS: int = 10


var islands = {
	"Sumatra": { "development": 0, "emission": 10, "population": 100 },
	"Kalimantan": { "development": 0, "emission": 10, "population": 100 },
	"Papua": { "development": 0, "emission": 10, "population": 100 },
	"Jawa": { "development": 0, "emission": 10, "population": 100 },
	"Sulawesi": { "development": 0, "emission": 10, "population": 100 }
}

func _ready():
	update_week_label()
	update_resource_label()
	#get_tree().root.print_tree_pretty()

func _process(_delta: float) -> void:
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
	if week < MAX_WEEKS:
		week += 1
		update_week_label()
		show_development_levels()
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
		print("🎉 You Win!")
		get_tree().change_scene_to_file("res://scenes/winning.tscn")
	else:
		print("💀 You Lose!")
		get_tree().change_scene_to_file("res://scenes/lose.tscn")



func weekly_income_resource():
	ResourceCount.add_money(500)
	update_resource_label()

func update_week_label():
	week_counter.text = "Week: " + str(week)
	print("Week Updated, Week: ", week)

func update_resource_label():
	resource_counter.text = "Resource: " + str(ResourceCount.resource)
	print("Resource Updated, Current Resource: ", ResourceCount.resource)

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

		var required_dev = 2

		if dev_level < required_dev:
			islands[island]["emission"] += 2  
			islands[island]["population"] -= 5 
			print(island, " development too low! Emission increased to ", islands[island]["emission"], ", Population reduced to ", islands[island]["population"])
		else:
			print(island, " is developing well. No penalty.")

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
