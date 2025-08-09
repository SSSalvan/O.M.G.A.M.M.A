extends GutTest

var game_scene
var previousResource: int

func before_each():
	game_scene = preload("res://scenes/main_gameplay.tscn").instantiate()

func after_each():
	game_scene.queue_free()

func test_initial_resource():
	var game_manager = game_scene.get_node("GameManager")
	game_manager._ready()
	print("Running function: test_initial_resource()")
	print("Current resource (start): ", ResourceCount.resource)
	assert_eq(ResourceCount.resource, 500, "Initial resource should be 500")

func test_end_week_resource_increase():
	var game_manager = game_scene.get_node("GameManager")
	previousResource = ResourceCount.resource
	game_manager.weekly_income_resource()
	print("Running function: test_end_week_resource_increase()")
	print("Resource before week end: ", previousResource)
	print("Resource after week end: ", ResourceCount.resource)
	assert_eq(ResourceCount.resource, previousResource+500, "Resource should be increased by 500")

func test_random_amount_end_week_resource_increase():
	var game_manager = game_scene.get_node("GameManager")
	
	for i in range(50): 
		var random_int = randi_range(100, 10000)
		ResourceCount.resource = random_int
		previousResource = ResourceCount.resource
		game_manager.weekly_income_resource()
		
		print("Run #%d" % (i + 1))
		print("Resource before week end: ", previousResource)
		print("Resource after week end: ", ResourceCount.resource)
		
		assert_eq(ResourceCount.resource, previousResource + 500, "Resource should be increased by 500")

func test_integer_limit():
	var game_manager = game_scene.get_node("GameManager")
	
	# Simulate a very high value close to the 32-bit signed int limit
	ResourceCount.resource = 1_000_000_000  # Start high
	for i in range(4):  # Multiply a few times
		ResourceCount.resource *= 2  # Must assign the result back
	
	var previous_resource = ResourceCount.resource
	
	game_manager.weekly_income_resource()
	
	var new_resource = ResourceCount.resource
	assert(new_resource > previous_resource, "Resource did not increase as expected")
	assert(new_resource <= 2_147_483_647, "Resource exceeded 32-bit integer limit")
