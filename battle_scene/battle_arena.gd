class_name BattleArena extends Node2D
## Static functions will act as global functions, accesible by all scripts(mainly minions)


# Arrays containing each team's minions(For testing)
@export var allies_exp: Array[PackedScene]
@export var enemies_exp: Array[PackedScene]

@onready var select_filter: CanvasModulate = $CanvasModulate

@onready var bm: BattleManager = $"/root/BattleManager"
@onready var move_layer: CanvasLayer = $MoveLayer

func _ready() -> void:
	bm.arena = self
	_ready_minions()
	bm.next_turn()

## Instantiate minions
func _ready_minions():
	for idx in range(allies_exp.size()):
		var minion: Minion = allies_exp[idx].instantiate()
		minion.get_node("Sprite").flip_h = true
		minion.add_to_group("allies")
		bm.allies.append(minion)
		bm.turn_order.append(minion)
		(get_node("Allies/" + str(idx + 1))).add_child(minion)
	
	for idx in range(enemies_exp.size()):
		var minion: Minion = enemies_exp[idx].instantiate()
		minion.add_to_group("enemies")
		bm.turn_order.append(minion)
		bm.enemies.append(minion)
		(get_node("Enemies/" + str(idx + 1))).add_child(minion)
	
	# Arranging minions with respect to speed through bubble sort
	for i in range(bm.turn_order.size()):
		var swapped = false
		
		for j in range(bm.turn_order.size() - i - 1):
			if bm.turn_order[j].minion_data.speed < bm.turn_order[j + 1].minion_data.speed:
				var temp = bm.turn_order[j]
				bm.turn_order[j] = bm.turn_order[j+1]
				bm.turn_order[j+1] = temp
				swapped = true
		
		if not swapped:
			break
