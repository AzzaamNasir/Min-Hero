extends Node2D
class_name MoveAnim

signal event_triggered

@export var enabled := true

enum AnimList{
	SLIDE,
	SLIDE_HORIZONTAL,
	ROTATE_SPRITE,
	SCALE,
	FADE,
}

var anim_list : Dictionary = {
	AnimList.SLIDE : Callable(slide),
	AnimList.ROTATE_SPRITE : Callable(rotate_sprite),
	AnimList.SCALE : Callable(scale_sprite),
	AnimList.SLIDE_HORIZONTAL : Callable(slide_horizontal),
	AnimList.FADE : Callable(fade),
}

## Which animation to use
@export var select_animation : AnimList:
	set(value):
		select_animation = value
		notify_property_list_changed()
## Motion-Time Graph of the animation
@export var motion_curve : Curve = Curve.new()
## Should this animation and the next run together
@export var simul := true
## How much time the animation lasts for(For looped animations, this is time for each loop)
@export var anim_time := 2.0
## The final value of the animation
@export var final_val := 0.0
## Custom timestamp at which the next animation is started(keep simul true if you want to use this)
@export var event := 0.0
## Reusing previous assets
@export var asset: Sprite2D 
var event_done := false

var animation : Callable:
	get:
		return anim_list[select_animation]

func play_anim():
	# If no asset has been defined to be animated, pick the first child of this animation node
	if asset == null:
		asset = get_child(0)
	# If animations play sequentially, set event to end of animation, otherwise use custom event
	if not simul:
		event = 1.0
	elif event == 0:
		event_triggered.emit()
	else:
		event = event / anim_time
	
	var tween = get_tree().create_tween()
	# If this is the last animation, make it'
	if get_parent().get_child(-1) == self:
		tween.finished.connect(func(): get_parent().completion_status += 1)
	
	animation.bind(tween).call()

func rotate_sprite(tween: Tween):
	var starting_val = asset.rotation_degrees
	var prev_time : float = 0.0
	
	tween.tween_method(# This means the time variable will go from 0 to 1 over anim_time
		func(time : float):# Function start
		asset.rotation_degrees = starting_val + _graph_sample(time)
		_check_time(prev_time ,time)
		prev_time = time# Function end
		, 0.0, 1.0, anim_time)

func slide(tween: Tween):
	# Setup the animation system
	var prev_time : float = 0.0
	
	tween.tween_method(func(time): 
		asset.position.y = _graph_sample(time)
		# Check if event has reached
		if (not event_done) and ((event == time) or (event > prev_time and event < time)):
			event_triggered.emit()
			event_done = true
		prev_time = time
		,0.0 , 1.0, anim_time)

func slide_horizontal(tween: Tween):
	# Setup animation system
	var prev_time : float = 0.0
	
	tween.tween_method(func(time):
		asset.position.x = _graph_sample(time)
		if (not event_done) and ((event == time) or (event > prev_time and event < time)):
			event_triggered.emit()
			event_done = true
		prev_time = time
		, 0.0, 1.0, anim_time)


func scale_sprite():
	var prev_time : float = 0.0
	
	var tween = get_tree().create_tween()
	tween.finished.connect(func(): tween.kill())
	tween.tween_method(func(time : float):
		asset.scale = Vector2.ONE * _graph_sample(time)
		if (not event_done) and ((event == time) or (event > prev_time and event < time)):
			event_triggered.emit()
			event_done = true
		prev_time = time
		,0.0 ,1.0, anim_time)
	
	if event != 0:
		await event_triggered

func fade():
	var prev_time : float = 0.0
	if not simul:
		event = 1.0
	else:
		event = event / anim_time
	
	var tween = get_tree().create_tween()
	tween.finished.connect(func(): tween.kill())
	tween.tween_method(func(time : float):
		asset.modulate.a = motion_curve.sample(time)
		if (not event_done) and ((event == time) or (event > prev_time and event < time)):
			event_triggered.emit()
			event_done = true
		prev_time = time
		,0.0 ,1.0, anim_time)
	
	if event != 0:
		await event_triggered

func _check_time(prev_time, time) -> void:
	if (event == time) or (event > prev_time and event < time):
		event_triggered.emit()
		event_done = true

func _graph_sample(time) -> float:
	return motion_curve.sample(time) * final_val
