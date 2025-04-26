extends CanvasLayer

# Labels for item quantities
@onready var item0Label: Label = $BG_ShopPanel/PanelSurya/QuantityPanel
@onready var item1Label: Label = $BG_ShopPanel/TurbinAngin/QuantityTurbin
@onready var item2Label: Label = $BG_ShopPanel/ClimateEducation/QuantityEducation
@onready var item3Label: Label = $BG_ShopPanel/RainforestRestoration/QuantityReforestation
@onready var item4Label: Label = $BG_ShopPanel/WastetoEnergyPlant/QuantityEnergyPlant
@onready var item5Label: Label = $BG_ShopPanel/ElectricVehicleSubsidy/QuantityElectricVehicle
@onready var item6Label: Label = $BG_ShopPanel/GreenBuilding/QuantityGreenBuilding
@onready var item7Label: Label = $BG_ShopPanel/BlueCarbonConservation/QuantityCarbonConservation
@onready var item8Label: Label = $BG_ShopPanel/OceanCleanupDrone/QuantityCleanupDrone
@onready var item9Label: Label = $BG_ShopPanel/CarbonStorageDome/QuantityStorageDome
@onready var item10Label: Label = $BG_ShopPanel/SoilRestorationKit/QuantitySoilRestoration
@onready var item11Label: Label = $BG_ShopPanel/AntiErosionBarrier/QuantityAntiErosion

# Labels for item prices
@onready var price0Label: Label = $BG_ShopPanel/PanelSurya/PricePanel
@onready var price1Label: Label = $BG_ShopPanel/TurbinAngin/PriceTurbin
@onready var price2Label: Label = $BG_ShopPanel/ClimateEducation/PriceEducation
@onready var price3Label: Label = $BG_ShopPanel/RainforestRestoration/PriceReforestation
@onready var price4Label: Label = $BG_ShopPanel/WastetoEnergyPlant/PriceEnergyPlant
@onready var price5Label: Label = $BG_ShopPanel/ElectricVehicleSubsidy/PriceElectricVehicle
@onready var price6Label: Label = $BG_ShopPanel/GreenBuilding/PriceGreenBuilding
@onready var price7Label: Label = $BG_ShopPanel/BlueCarbonConservation/PriceCarbonConservation
@onready var price8Label: Label = $BG_ShopPanel/OceanCleanupDrone/PriceCleanupDrone
@onready var price9Label: Label = $BG_ShopPanel/CarbonStorageDome/PriceStorageDome
@onready var price10Label: Label = $BG_ShopPanel/SoilRestorationKit/PriceSoilRestoration
@onready var price11Label: Label = $BG_ShopPanel/AntiErosionBarrier/PriceAntiErosion

func _ready():
	# Set up price labels
	price0Label.text = "Price: %d" % ShopItems.itemPrice[0]
	price1Label.text = "Price: %d" % ShopItems.itemPrice[1]
	price2Label.text = "Price: %d" % ShopItems.itemPrice[2]
	price3Label.text = "Price: %d" % ShopItems.itemPrice[3]
	price4Label.text = "Price: %d" % ShopItems.itemPrice[4]
	price5Label.text = "Price: %d" % ShopItems.itemPrice[5]
	price6Label.text = "Price: %d" % ShopItems.itemPrice[6]
	price7Label.text = "Price: %d" % ShopItems.itemPrice[7]
	price8Label.text = "Price: %d" % ShopItems.itemPrice[8]
	price9Label.text = "Price: %d" % ShopItems.itemPrice[9]
	price10Label.text = "Price: %d" % ShopItems.itemPrice[10]
	price11Label.text = "Price: %d" % ShopItems.itemPrice[11]

# Standardized buy functions
func _on_buy_panel_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[0]:
		ShopItems.add_item(0, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[0])
		print("Bought, now ", ShopItems.get_item_count(0), " Solar Panel")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item0Label.text = "%d" % ShopItems.get_item_count(0)

func _on_buy_turbin_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[1]:
		ShopItems.add_item(1, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[1])
		print("Bought, now ", ShopItems.get_item_count(1), " Wind Turbine")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item1Label.text = "%d" % ShopItems.get_item_count(1)

func _on_buy_education_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[2]:
		ShopItems.add_item(2, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[2])
		print("Bought, now ", ShopItems.get_item_count(2), " Climate Education")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item2Label.text = "%d" % ShopItems.get_item_count(2)

func _on_buy_reforestation_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[3]:
		ShopItems.add_item(3, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[3])
		print("Bought, now ", ShopItems.get_item_count(3), " Rainforest Restoration")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item3Label.text = "%d" % ShopItems.get_item_count(3)

func _on_buy_energy_plant_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[4]:
		ShopItems.add_item(4, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[4])
		print("Bought, now ", ShopItems.get_item_count(4), " Waste-to-Energy Plant")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item4Label.text = "%d" % ShopItems.get_item_count(4)

func _on_buy_electric_vehicle_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[5]:
		ShopItems.add_item(5, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[5])
		print("Bought, now ", ShopItems.get_item_count(5), " Electric Vehicle Subsidy")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item5Label.text = "%d" % ShopItems.get_item_count(5)

func _on_buy_green_building_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[6]:
		ShopItems.add_item(6, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[6])
		print("Bought, now ", ShopItems.get_item_count(6), " Green Building")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item6Label.text = "%d" % ShopItems.get_item_count(6)

func _on_buy_carbon_conservation_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[7]:
		ShopItems.add_item(7, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[7])
		print("Bought, now ", ShopItems.get_item_count(7), " Blue Carbon Conservation")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item7Label.text = "%d" % ShopItems.get_item_count(7)

func _on_buy_cleanup_drone_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[8]:
		ShopItems.add_item(8, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[8])
		print("Bought, now ", ShopItems.get_item_count(8), " Ocean Clean-up Drone")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item8Label.text = "%d" % ShopItems.get_item_count(8)

func _on_buy_storage_dome_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[9]:
		ShopItems.add_item(9, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[9])
		print("Bought, now ", ShopItems.get_item_count(9), " Carbon Storage Dome")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item9Label.text = "%d" % ShopItems.get_item_count(9)

func _on_buy_soil_restoration_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[10]:
		ShopItems.add_item(10, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[10])
		print("Bought, now ", ShopItems.get_item_count(10), " Soil Restoration Kit")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item10Label.text = "%d" % ShopItems.get_item_count(10)

func _on_buy_anti_erosion_pressed() -> void:
	if ResourceCount.resource >= ShopItems.itemPrice[11]:
		ShopItems.add_item(11, 1)
		ResourceCount.subtract_money(ShopItems.itemPrice[11])
		print("Bought, now ", ShopItems.get_item_count(11), " Anti-Erosion Barrier")
		print("Full inventory:", ShopItems.itemCount)  # Debug log
		item11Label.text = "%d" % ShopItems.get_item_count(11)

func refresh_item_labels():
	item0Label.text = "%d" % ShopItems.get_item_count(0)
	item1Label.text = "%d" % ShopItems.get_item_count(1)
	item2Label.text = "%d" % ShopItems.get_item_count(2)
	item3Label.text = "%d" % ShopItems.get_item_count(3)
	item4Label.text = "%d" % ShopItems.get_item_count(4)
	item5Label.text = "%d" % ShopItems.get_item_count(5)
	item6Label.text = "%d" % ShopItems.get_item_count(6)
	item7Label.text = "%d" % ShopItems.get_item_count(7)
	item8Label.text = "%d" % ShopItems.get_item_count(8)
	item9Label.text = "%d" % ShopItems.get_item_count(9)
	item10Label.text = "%d" % ShopItems.get_item_count(10)
	item11Label.text = "%d" % ShopItems.get_item_count(11)
