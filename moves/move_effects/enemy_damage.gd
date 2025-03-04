class_name SingleEnemyDamage extends MoveEffects

@export var damage: float

func _init() -> void:
	super()
	target_type = 0
	target_no = 1

func apply_effect():
	for minion: Minion in BattleManager.hitlist:
		BattleManager.current_target = minion
		
		if add_animation:
			await BattleManager.request_anim(anim_idx)
		
		print("effect complete")
		minion.health -= damage
		effect_applied.emit()
