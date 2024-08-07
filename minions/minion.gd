extends Node2D
class_name Minion
## This class contains all the properties of a minion, such as available moves, types etc

@export var minion_data : MinionData
@export var level : int
@onready var tree: SkillTree = $SkillTree


func _ready() -> void:
	pass
