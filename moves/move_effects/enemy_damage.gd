class_name EnemyDamage extends MoveEffects

@export var damage: float
@export var target_no: int = 1

func apply_effect():
	for minion: Minion in BattleManager.hitlist:
		minion.health -= damage
		effect_applied.emit()
