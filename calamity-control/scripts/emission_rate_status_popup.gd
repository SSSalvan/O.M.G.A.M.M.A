extends Control

@onready var status: Label = $"Status Report_ Island_name"
@onready var current_emission_rate: Label = $"Emission Rate"
@onready var current_population: Label = $"Population Count"
@onready var current_development: Label = $"Development Level"

var status_report_island: String
var emission_rate: int
var population_count: int
var development_level: int

func StatusPopup(slot, item):
	%EmissionRatePopUp.popup()

func HideStatusPopup():
	%EmissionRatePopUp.hide()

# New function to update the labels dynamically
func update_status(island_name: String, emission: int, population: int, development: int):
	status_report_island = island_name
	emission_rate = emission
	population_count = population
	development_level = development


	status.text = "Status Report: " + str(island_name)
	current_emission_rate.text = "Emission Rate: " + str(emission) + "%"
	current_population.text = "Population: " + str(population)
	current_development.text = "Development Level: " + str(development)
