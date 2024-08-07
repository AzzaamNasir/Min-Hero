extends Resource
class_name MoveEffects

enum Type{
	DAMAGES,
	HEALS,
	BUFFS,
	DEBUFFS,
}

enum Targets{
	ENEMIES,
	ALLIES,
}

enum Selector{
	PLAYER,
	RANDOM,
	ALL,
	SELF,
}

@export var type : Type

var target_type : Targets
var target_selector : Selector
var target_no : int

var value : int
var bonus_value : int

@export var anim_idx : int = -1
