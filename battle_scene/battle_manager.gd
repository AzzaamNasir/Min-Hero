extends Node

enum States{
	NONE,
	MOVING,
	SELECTING,
}

signal turn_started
signal move_selected(move: Move)
signal selection_finished
signal turn_finished

var state: States = States.NONE
var arena: Node

var allies: Array[Minion]
var enemies: Array[Minion]
## Stores all currently alive minions in order of their turns
var turn_order: Array[Minion]
var turn: int = 0
var current_minion: Minion
## Stores current move
var current_move: Move
var current_target: Minion
## Stores all the minions selected to be attacked
var hitlist: Array[Minion]
## Stores how many targets have to be chosen
var target_no: int:
	set(value):
		if target_no == 0 and state == States.SELECTING:
			Minion.minions_under_mouse.clear()
			selected = null
			Input.set_default_cursor_shape(Input.CURSOR_ARROW)
			selection_finished.emit()
		
## Stores the minion on whom the mouse is currently
var selected: Minion = null

func _ready() -> void:
	move_selected.connect(_on_move_selected)

func request_anim(idx: int):
	arena.move_layer.add_child(current_move)
	current_move.global_position = current_target.global_position 
	await current_move.play(idx)
	print("anim_ended")

func _on_move_selected(move: Move):
	current_move = move
	
	for effect: MoveEffects in move.move_data.effects:
		target_no = effect.target_no
		
		_set_targets(effect)

		if effect.target_type == 0:
			get_tree().call_group("enemies", "state_change", Minion.States.SELECTABLE)
		else:
			get_tree().call_group("allies", "state_change", Minion.States.SELECTABLE)
		
		state = States.SELECTING
		
		await selection_finished
		
		await effect.apply_effect()
		
		
	get_tree().call_group("allies", "state_change", Minion.States.IDLE)
	get_tree().call_group("enemies", "state_change", Minion.States.IDLE)
	arena.select_filter.hide()
	
	turn_finished.emit()
	hitlist.clear()
	turn = turn + 1 if turn < turn_order.size() - 1 else 0
	next_turn()

func kill_minion(minion: Minion):
	turn_order.erase(minion)
	minion.remove_from_group("allies")
	minion.remove_from_group("enemies")
	minion.queue_free()

func next_turn():
	arena.select_filter.show()
	current_minion = turn_order[turn]
	current_minion.state_change(Minion.States.MOVING)
	state = States.MOVING

func check_effectiveness(move_type: Databases.MoveTypes, minion_type1: Databases.MinionTypes,\
 minion_type2: Databases.MinionTypes) -> int:
	var result : int = 0
	var list : Dictionary = Databases.type_matrix[move_type]
	if list.has(minion_type1):
		result += list[minion_type1]
	if list.has(minion_type2):
		result += list[minion_type2]
	return result

func _set_targets(effect: MoveEffects):
	if current_minion.is_in_group("enemies"):
		match effect.target_type:
			Databases.Targets.ENEMY:
				effect.target_type = 1
			Databases.Targets.ALLY:
				effect.target_type = 0

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == 1 and not event.pressed and selected != null:
		if selected.state == Minion.States.SELECTABLE:
			hitlist.append(selected)
			target_no -= 1
