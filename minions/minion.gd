extends Node2D
class_name Minion
## This class contains all the properties of a minion, such as available moves, types etc

@export var minion_data: MinionData
@export var level: int
@export var available_skills: Array[PackedScene]

var atk: float
var health: float:
	set(value):
		print(get_parent().name)
		health = value
var healing: float
var speed: float
var energy: float

var is_selectable = false
static var minions_under_mouse: Array[Minion]

@onready var sprite: Sprite2D = $Sprite as Sprite2D
@onready var tree_1: SkillTree = $Specialty1 as SkillTree
@onready var tree_2: SkillTree = $Specialty2 as SkillTree
@onready var tree_3: SkillTree = $Specialty3 as SkillTree
@onready var move_menu: MoveMenu = $MoveMenu as MoveMenu
@onready var selector: Area2D = $Selector as Area2D

func _ready() -> void:
	atk = minion_data.attack
	health = minion_data.health
	healing = minion_data.healing
	speed = minion_data.speed
	energy = minion_data.energy
	
	BattleManager.selection_finished.connect(make_unselectable)
	sprite.texture = minion_data.texture
	move_menu.setup_move_menu(self)
	BattleManager.turn_finished.connect(make_unselectable)
	selector.mouse_entered.connect(_on_selector_mouse_entered)
	selector.mouse_exited.connect(_on_selector_mouse_exited)
	selector.get_child(0).shape.size = sprite.get_rect().size * sprite.scale.x

# This function makes the minion available to be selected
func make_selectable():
	is_selectable = true
	highlight()

func make_unselectable():
	is_selectable = false
	unhighlight()

func start_turn():
	highlight()
	move_menu.show()

func on_move_selected(move_scene: PackedScene) -> void:
	var move: Move = move_scene.instantiate()
	_set_targets(move)
	BattleManager.move_selected.emit(move)
	
	move_menu.hide()
	make_unselectable()

func _set_targets(move: Move):
	if self.is_in_group("enemies"):
		match move.move_data.target:
			Databases.Targets.ENEMY:
				move.move_data.target = Databases.Targets.ALLY

## Makes it appear over the screen tint
func highlight():
	(material as CanvasItemMaterial).light_mode = CanvasItemMaterial.LIGHT_MODE_UNSHADED

func unhighlight():
	(material as CanvasItemMaterial).light_mode = CanvasItemMaterial.LIGHT_MODE_NORMAL

# It's just the selection code, it works pretty well so best left untouched
func _on_selector_mouse_entered() -> void:
	if is_selectable:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		minions_under_mouse.append(self)
	if minions_under_mouse.size() == 1:
		BattleManager.selected = minions_under_mouse[0]
	else:
		BattleManager.selected = null
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_selector_mouse_exited() -> void:
	minions_under_mouse.erase(self)
	if minions_under_mouse.size() == 1:
		BattleManager.selected = minions_under_mouse[0]
		if is_selectable:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		BattleManager.selected = null
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
