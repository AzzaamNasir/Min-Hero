extends Node2D
class_name Move

signal move_finished # This signals to move onto the next animation
signal move_actually_finished # This signals when the sprite can be removed

@export var move_data: MoveData
@export var sequential_anim := true

var completion_status := 0:
	set(value):
		if value == 3:
			move_actually_finished.emit()
			queue_free()
		completion_status = value

func _ready() -> void:
	play()
	move_finished.connect(func(): completion_status += 1)
	

func _do_move():
	for idx in move_data.effects.size():
		var effect: MoveEffects = move_data.effects[idx]
		if idx == move_data.effects.size() - 1:
			effect.effect_applied.connect(func(): completion_status += 1)
		effect.apply_effect()


func play():
	for idx in get_child_count():
		var anim: MoveAnim = get_child(idx)
		anim.play_anim()
		if sequential_anim:
			await anim.event_triggered
	
	_do_move()
	move_finished.emit()
