extends Node
var itemName: Array[String] = [""]
var itemCount: Array[int] = []
var itemPrice: Array[int] = []

var howManyItemsBro = 52
func _ready():
	itemName.resize(howManyItemsBro)  # now it's [0, 0, 0, 0, 0]
	itemCount.resize(howManyItemsBro)
	itemPrice.resize(howManyItemsBro)
	
	itemName[0]  = "Solar Panel" #debug
	itemPrice[0] = 300
	
	itemName[1]  = "Green Building" #debug
	itemPrice[1] = 450
	
	itemName[2]  = "Urban Foresting Pack" #debug
	itemPrice[2] = 0

	itemName[3]  = "Climate Education Program" #debug
	itemPrice[3] = 0

	itemName[4]  = "Rainforest Restoration" #debug
	itemPrice[4] = 0

	itemName[5]  = "Waste-to-Energy Plant" #debug
	itemPrice[5] = 0

	itemName[6]  = "Electric Vehicle Subsidy" #debug
	itemPrice[6] = 0

	itemName[7]  = "Public Transport Upgrade" #debug
	itemPrice[7] = 0

	itemName[8]  = "Wind Turbine Construction" #debug
	itemPrice[8] = 0

	itemName[9]  = "Blue Carbon Conservation" #debug
	itemPrice[9] = 0

	itemName[10] = "Ocean Clean-up Drone" #debug
	itemPrice[10]= 0

	itemName[11] = "Reforestation Grant" #debug
	itemPrice[11]= 0

	itemName[12] = "Carbon Storage Dome" #debug
	itemPrice[12]= 0

	itemName[13] = "Soil Restoration Kit" #debug
	itemPrice[13]= 0

	itemName[14] = "Anti-Erosion Barrier" #debug
	itemPrice[14]= 0
	
	itemName[15] = "Lab-Grown Meat Lab" #debug
	itemPrice[15] = 0

	itemName[16] = "Organic Feed Initiative" #debug
	itemPrice[16] = 0

	itemName[17] = "Virtual Conference Promotion" #debug
	itemPrice[17] = 0

	itemName[18] = "Grid Upgrade Tech" #debug
	itemPrice[18] = 0

	itemName[19] = "Community Solar Panel Pack" #debug
	itemPrice[19] = 0

	itemName[20] = "Green Energy Subsidy" #debug
	itemPrice[20] = 0

	itemName[21] = "Fossil Fuel Tax" #debug
	itemPrice[21] = 0

	itemName[22] = "Eco Housing Program" #debug
	itemPrice[22] = 0

	itemName[23] = "Sustainable Community Center" #debug
	itemPrice[23] = 0

	itemName[24] = "Plant-Based Campaign" #debug
	itemPrice[24] = 0

	itemName[25] = "Methane Capture System" #debug
	itemPrice[25] = 0

	itemName[26] = "Oil Clean-up Robots" #debug
	itemPrice[26] = 0

	itemName[27] = "Maritime Regulation Upgrade" #debug
	itemPrice[27] = 0

	itemName[28] = "Factory Emission Filter" #debug
	itemPrice[28] = 0

	itemName[29] = "Green Industry Incentives" #debug
	itemPrice[29] = 0

	itemName[30] = "Geoengineering Pilot" #debug
	itemPrice[30] = 0

	itemName[31] = "Urban Greening Project" #debug
	itemPrice[31] = 0

	itemName[32] = "Bike Lane Network" #debug
	itemPrice[32] = 0

	itemName[33] = "Leak Detection System" #debug
	itemPrice[33] = 0

	itemName[34] = "Transition to Biogas" #debug
	itemPrice[34] = 0

	itemName[35] = "Green AC Tech" #debug
	itemPrice[35] = 0

	itemName[36] = "Rooftop Garden Kits" #debug
	itemPrice[36] = 0

	itemName[37] = "Plastic Ban Policy" #debug
	itemPrice[37] = 0

	itemName[38] = "Biodegradable Material R&D" #debug
	itemPrice[38] = 0

	itemName[39] = "Fire Drone Patrol" #debug
	itemPrice[39] = 0

	itemName[40] = "Forest Moisture Enhancer" #debug
	itemPrice[40] = 0

	itemName[41] = "Climate Monitoring Station" #debug
	itemPrice[41] = 0

	itemName[42] = "Weather Resilience System" #debug
	itemPrice[42] = 0

	itemName[43] = "Sustainable Fishing License" #debug
	itemPrice[43] = 0

	itemName[44] = "Marine Protected Area" #debug
	itemPrice[44] = 0

	itemName[45] = "Electric Vehicle Grant" #debug
	itemPrice[45] = 0

	itemName[46] = "Public Transport Funding" #debug
	itemPrice[46] = 0

	itemName[47] = "Green Crypto Standard" #debug
	itemPrice[47] = 0

	itemName[48] = "Renewable Mining Facility" #debug
	itemPrice[48] = 0

	itemName[49] = "Cool Roof Coating" #debug
	itemPrice[49] = 0

	itemName[50] = "Heatwave Awareness System" #debug
	itemPrice[50] = 0

	itemName[51] = "Peat Rewetting System" #debug
	itemPrice[51] = 0

	itemName[52] = "Peatland Protection Patrol" #debug
	itemPrice[52] = 0

	print("Item names array content: ", itemName)

func startGame():
	for i in range (howManyItemsBro):
		itemCount[i] = 0
