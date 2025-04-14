extends Area2D
class_name RecycleItem

@export var fall: float = 300.0
@onready var sprite = $Sprite2D
@export var item_type: String

var velocity = Vector2.ZERO
var can_fall = false

func _ready():
	print("Item ready")
	sprite.scale = Vector2(0.2, 0.2) 

func _process(delta):
	if can_fall:
		velocity.y += fall * delta
		position += velocity * delta

func set_texture(texture: Texture2D, type: String):
	if sprite:
		sprite.texture = texture
		sprite.scale = Vector2(100.0 / texture.get_width(), 100.0 / texture.get_height())
		item_type = type

func start_falling():
	can_fall = true
