extends Node2D

# Arrays containing each team's minions(Temporary, will shift to autoload)
@export var allies: Array[PackedScene]
@export var enemies: Array[PackedScene]

@onready var select_filter: CanvasModulate = $CanvasModulate

func _ready() -> void:
	await ready_minions() 
	BattleManager.turn_started.connect(func(): select_filter.show())
	BattleManager.selection_finished.connect(func(): select_filter.hide())
	BattleManager.next_turn()

## Instantiate minions
func ready_minions():
	for idx in range(allies.size()):
		var minion: Minion = allies[idx].instantiate()
		minion.get_node("Sprite").flip_h = true
		minion.add_to_group("allies")
		BattleManager.allies.append(minion)
		BattleManager.turn_order.append(minion)
		(get_node("Allies/" + str(idx + 1))).add_child(minion)
	
	for idx in range(enemies.size()):
		var minion: Minion = enemies[idx].instantiate()
		minion.add_to_group("enemies")
		BattleManager.turn_order.append(minion)
		BattleManager.enemies.append(minion)
		(get_node("Enemies/" + str(idx + 1))).add_child(minion)
	
	# Arranging minions with respect to speed through bubble sort
	for i in range(BattleManager.turn_order.size()):
		var swapped = false
		
		for j in range(BattleManager.turn_order.size() - i - 1):
			if BattleManager.turn_order[j].minion_data.speed < BattleManager.turn_order[j + 1].minion_data.speed:
				var temp = BattleManager.turn_order[j]
				BattleManager.turn_order[j] = BattleManager.turn_order[j+1]
				BattleManager.turn_order[j+1] = temp
				swapped = true
		
		if not swapped:
			break
