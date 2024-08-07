extends Node2D
class_name Move

@export var ability_name : String
@export var move_class : Databases.MoveClasses
@export var texture : Texture2D
@export var energy : int
@export var element: Databases.MoveTypes
@export var effects : Array[MoveEffects]
