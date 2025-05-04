extends GutTest

var game_manager
var province_node

func before_each():
	game_manager = preload("res://scenes/main_gameplay.tscn").instantiate()
	add_child(game_manager)
	# Access the Riau province node from the GameManager
	province_node = game_manager.get_node("GameManager/Riau")  # Adjust path as necessary

func test_initial_development_level_is_zero():
	assert_eq(province_node.development_level, 0)

func test_can_develop_returns_true_when_resources_enough():
	province_node.resource_amount = 500  # Ensure resource_amount is exposed in the province node script
	assert_true(province_node.can_develop())

func test_can_develop_returns_false_when_resources_not_enough():
	province_node.resource_amount = 200
	assert_false(province_node.can_develop())

func test_develop_increases_development_level():
	province_node.resource_amount = 500
	province_node.develop()
	assert_eq(province_node.development_level, 1)

func test_develop_does_not_work_without_resources():
	province_node.resource_amount = 100
	province_node.develop()
	assert_eq(province_node.development_level, 0)

func after_each():
	game_manager.queue_free()
