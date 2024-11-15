extends Resource
class_name MoveData

@export var ability_name : String
@export var move_class : Databases.MoveClasses
@export var texture : Texture2D
@export var energy : int
@export var element: Databases.MoveTypes
@export var effects : Array[MoveEffects]
@export var target: Databases.Targets
@export var target_no: int = 1
