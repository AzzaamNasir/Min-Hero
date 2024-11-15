extends Node2D

@export var speed : float

var bg_elements : Array

func _ready() -> void:
	# Get list of children
	bg_elements = get_children()
	child_order_changed.connect(func():
		bg_elements = get_children()
		)

func _process(delta: float) -> void:
	# Move all the nodes within
	for element in bg_elements:
		element.position.x -= speed * delta * element.speed_scale
		if element.right <= 0:
			element.global_position.x = 1920 + element.gap
