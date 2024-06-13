extends Resource
class_name MinionData
## This class contains all the properties of a minion, such as available moves, types etc

enum Elements{
	NONE,
	NORMAL,
	FLYING,
	PLANT,
	WATER,
	WARTH,
	FIRE,
	ELECTRIC,
	ROBOT,
	DINO,
	UNDEAD,
	DEMONIC,
	HOLY,
	ICE,
	TITAN,
}

@export var name : String
@export var level : int
@export var element1 : Elements
@export var element2 : Elements
@export var attack : int
@export var health : int
@export var healing : int
@export var speed : int
@export var energy : int

func create_minion(parent : Node):
	pass
