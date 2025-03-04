extends Node2D
class_name Minion
## This class contains all the properties of a minion, such as available moves, types etc

enum States{
	IDLE,
	MOVING,
	SELECTABLE,
	SELECTED,
	MOV_SEL,
}

@export var minion_data: MinionData
@export var level: int
@export var available_skills: Array[PackedScene]

var state: States = States.IDLE

var atk: float
var health: float:
	set(value):
		if value <= 0:
			BattleManager.kill_minion(self)
		health = value

var healing: float
var speed: float
var energy: float

static var minions_under_mouse: Array[Minion]

@onready var sprite: Sprite2D = $Sprite
@onready var tree_1: SkillTree = $Specialty1
@onready var tree_2: SkillTree = $Specialty2
@onready var tree_3: SkillTree = $Specialty3
@onready var move_menu: MoveMenu = $MoveMenu
@onready var selector: Area2D = $Selector

func _ready() -> void:
	atk = minion_data.attack
	health = minion_data.health
	healing = minion_data.healing
	speed = minion_data.speed
	energy = minion_data.energy
	
	sprite.texture = minion_data.texture
	move_menu.setup_move_menu(self)
	selector.mouse_entered.connect(_on_selector_mouse_entered)
	selector.mouse_exited.connect(_on_selector_mouse_exited)
	selector.get_child(0).shape.size = sprite.get_rect().size * sprite.scale.x

# This function makes the minion available to be selected
func make_selectable():
	state == States.SELECTABLE
	highlight()

func make_unselectable():
	state == States.IDLE
	unhighlight()

func start_turn():
	highlight()
	move_menu.show()

func on_move_selected(move_scene: PackedScene) -> void:
	make_unselectable()
	var move: Move = move_scene.instantiate()
	BattleManager.move_selected.emit(move)
	move_menu.hide()


## Makes it appear over the screen tint
func highlight():
	(material as CanvasItemMaterial).light_mode = CanvasItemMaterial.LIGHT_MODE_UNSHADED

func unhighlight():
	(material as CanvasItemMaterial).light_mode = CanvasItemMaterial.LIGHT_MODE_NORMAL

# It's just the selection code, it works pretty well so best left untouched
func _on_selector_mouse_entered() -> void:
	_display_debug()
	if state == States.SELECTABLE:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		minions_under_mouse.append(self)
	if minions_under_mouse.size() == 1:
		BattleManager.selected = minions_under_mouse[0]
	else:
		BattleManager.selected = null
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func _on_selector_mouse_exited() -> void:
	$Debug.hide()
	minions_under_mouse.erase(self)
	if minions_under_mouse.size() == 1:
		BattleManager.selected = minions_under_mouse[0]
		if state == States.SELECTABLE:
			Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
	else:
		BattleManager.selected = null
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)

func state_change(to: States):
	if to == States.MOVING:
		start_turn()
		state = to
	
	if to == States.SELECTABLE:
		make_selectable()
		if state != States.MOVING:
			state = States.SELECTABLE
		else:
			state = States.MOV_SEL
	
	if to == States.IDLE:
		make_unselectable()
		state = States.IDLE

func _display_debug():
	var debug: Label = $Debug
	debug.text = "
	Current State: %s
	Health: %s
	" % [
		States.find_key(state),
		health
	]
	debug.show()
