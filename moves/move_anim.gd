@tool
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
## The Parent of the sprites this animation will affect
@export var assets : MoveAnim = self
## Should this animation and the next run together
@export var simul := true
## How much time the animation lasts for(For looped animations, this is time for each loop)
@export var anim_time := 2.0
## The final value of the animation
@export var final_val := 0.0
## The index of the asset to be used(Used if you have multiple assets which need modifying)
@export var asset_idx : Array[int] = []
## Custom timestamp at which the next animation is started(keep simul true if you want to use this)
@export var event := 0.0

var event_done := false
var sprites : Array[Sprite2D]

var animation : Callable:
	get:
		return anim_list[select_animation]

var animator : MoveAnimator 

func _ready() -> void:
	sprites.append_array(assets.get_children())

func slide():
	# Setup the animation system
	var prev_time : float = 0.0
	if not simul:
		event = 1.0
	else:
		event = event / anim_time
	if asset_idx == []:
		asset_idx = [0]
	
	# The actual animation
	var tween = get_tree().create_tween()
	tween.finished.connect(func(): tween.kill())
	tween.tween_method(func(time): 
		sprites[asset_idx[0]].position.y = _graph_sample(time)
		# Check if event has reached
		if (not event_done) and ((event == time) or (event > prev_time and event < time)):
			event_triggered.emit()
			event_done = true
		prev_time = time
		,0.0 , 1.0, anim_time)
	
	if event != 0.0:
		await event_triggered

func slide_horizontal():
	# Setup animation system
	var prev_time : float = 0.0
	if not simul:
		event = 1.0
	else:
		event = event / anim_time
	if asset_idx == []:
		asset_idx = [0]
	
	# The actual animation
	var tween = get_tree().create_tween()
	tween.finished.connect(func(): tween.kill())
	tween.tween_method(func(time):
		sprites[asset_idx[0]].position.x = _graph_sample(time)
		if (not event_done) and ((event == time) or (event > prev_time and event < time)):
			event_triggered.emit()
			event_done = true
		prev_time = time
		, 0.0, 1.0, anim_time)
	
	if event != 0:
		await event_triggered

func rotate_sprite():
	var prev_time : float = 0.0
	if not simul:
		event = 1.0
	else:
		event = event / anim_time
	if asset_idx == []:
		asset_idx = [0]
	var tween = get_tree().create_tween()
	tween.finished.connect(func(): tween.kill())
	
	tween.tween_method(func(time : float):
		sprites[asset_idx[0]].rotation_degrees = _graph_sample(time)
		if (not event_done) and ((event == time) or (event > prev_time and event < time)):
			event_triggered.emit()
			event_done = true
		prev_time = time
		, 0.0, 1.0, anim_time)
	
	if event != 0:
		await event_triggered

func scale_sprite():
	var prev_time : float = 0.0
	if not simul:
		event = 1.0
	else:
		event = event / anim_time
	if asset_idx == []:
		asset_idx = [0]
	
	var tween = get_tree().create_tween()
	tween.finished.connect(func(): tween.kill())
	tween.tween_method(func(time : float):
		sprites[asset_idx[0]].scale = Vector2.ONE * _graph_sample(time)
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
	if asset_idx == []:
		asset_idx = [0]
	
	var tween = get_tree().create_tween()
	tween.finished.connect(func(): tween.kill())
	tween.tween_method(func(time : float):
		sprites[asset_idx[0]].modulate.a = motion_curve.sample(time)
		if (not event_done) and ((event == time) or (event > prev_time and event < time)):
			event_triggered.emit()
			event_done = true
		prev_time = time
		,0.0 ,1.0, anim_time)
	
	if event != 0:
		await event_triggered


func _graph_sample(time) -> float:
	return motion_curve.sample(time) * final_val
