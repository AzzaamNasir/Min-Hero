class_name MoveEffects extends Resource

enum Selector{
	PLAYER,
	RANDOM,
	ALL,
	SELF,
}

signal anim_ended

@export var add_animation := false
@export var anim_idx := 0

var target_type: int
var target_no: int

signal effect_applied

func _init() -> void:
	resource_local_to_scene = true

func apply_effect():
	pass
