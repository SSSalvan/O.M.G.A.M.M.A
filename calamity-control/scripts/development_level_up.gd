extends Marker2D

@onready var dev_up_label: Label = $FloatingText
@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready():
	# Wait one frame so Label size is calculated
	await get_tree().process_frame
	dev_up_label.pivot_offset = dev_up_label.size / 2
	anim_player.play("level_up_popup")

func set_text(text_to_display: String):
	dev_up_label.text = text_to_display


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "level_up_popup":
		queue_free()
