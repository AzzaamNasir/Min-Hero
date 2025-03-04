class_name MotionAnim extends MoveAnim

@export var motion_curve: Curve

var asset: Node2D

func setup(owner: Node2D):
	super(owner)
	asset = owner.get_child(asset_idx)
	asset.show()
	if motion_curve == null:
		motion_curve = Curve.new()
		motion_curve.add_point(Vector2.ZERO, 0, 1, Curve.TANGENT_LINEAR)
		motion_curve.add_point(Vector2.ONE, 1, 0, Curve.TANGENT_LINEAR)

func _sample_curve(time, max_value) -> float:
	return motion_curve.sample(time) * max_value
