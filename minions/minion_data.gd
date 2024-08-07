extends Resource
class_name MinionData

@export var minion_name : String
@export var texture : Texture2D

@export var attack : int
@export var health : int
@export var healing : int
@export var speed : int
@export var energy : int
var gems_no : int

@export var element1 : Databases.MinionTypes
@export var element2 : Databases.MinionTypes

@export var starting_moves : Array[PackedScene]

