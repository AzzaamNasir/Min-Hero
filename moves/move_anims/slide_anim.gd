class_name SlideAnim extends MotionAnim

@export_enum("HORIZONTAL", "VERTICAL") var slide_type := 0
@export var slide_amount := 0.0

var initial_position :float

func setup(owner: Node2D):
	super(owner)
	if slide_type == 0:
		initial_position = asset.position.x
	elif slide_type == 0:
		initial_position = asset.position.y

func _play(tween: Tween):
	if slide_type == 0:
		tween.tween_method(_slide_horizontal, 0.0, 1.0, duration)
	elif slide_type == 1:
		tween.tween_method(_slide_vertical, 0.0, 1.0, duration)

func _slide_vertical(time: float):
	asset.position.y = initial_position - _sample_curve(time, slide_amount)

func _slide_horizontal(time: float):
	asset.position.x = initial_position + _sample_curve(time, slide_amount)
	
