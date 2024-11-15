extends Node

## Fired when a minion selects its move
signal turn_started
signal move_selected(move: Move)
signal selection_finished
signal turn_finished

var allies: Array[Minion]
var enemies: Array[Minion]
## Stores all currently alive minions in order of their turns
var turn_order: Array[Minion]
var turn: int = 0
## Is true if minions are being selected for an attack
var selection_phase := false
## Stores current move
var current_move: Move
## Stores all the minions selected to be attacked
var hitlist: Array[Minion]
## Stores how many targets have to be chosen
var target_no: int

## Stores the minion on whom the mouse is currently
var selected: Minion = null

## Stores a node rendered over everything else, all attack animation sprites are children of this
@onready var move_layer: Node2D = $MoveLayer
## Stores the node to play the music/audio
@onready var audio_player: AudioStreamPlayer = $AudioPlayer

func _ready() -> void:
	pass

func _input(event: InputEvent) -> void:
	# If minions are being selected, there is a minion under the mouse, and the left mouse button
	# is released, then:
	if (selection_phase and selected and event is InputEventMouseButton\
	 and event.is_released() and event.button_index == 1):
		# If minion hasn't already been selected, add it to the hitlist
		if hitlist.find(selected) == -1:
			hitlist.append(selected)
			selected.minions_under_mouse.clear()

func check_effectiveness(move_type: Databases.MoveTypes, minion_type1: Databases.MinionTypes,\
 minion_type2: Databases.MinionTypes) -> int:
	var result : int = 0
	var list : Dictionary = Databases.type_matrix[move_type]
	if list.has(minion_type1):
		result += list[minion_type1]
	if list.has(minion_type2):
		result += list[minion_type2]
	return result
