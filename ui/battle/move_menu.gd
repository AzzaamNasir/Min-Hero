class_name MoveMenu extends TextureRect

signal move_selected(move: PackedScene)

@onready var move1: TextureButton = %Move1
@onready var move2: TextureButton = %Move2
@onready var move3: TextureButton = %Move3
@onready var move4: TextureButton = %Move4
@onready var move5: TextureButton = %Move5
@onready var move6: TextureButton = %Move6

@onready var energy_bar: TextureProgressBar = %EnergyBar
@onready var energy: Label = %Energy

# Called when the node enters the scene tree for the first time.
func setup_move_menu(minion: Minion) -> void:
	move_selected.connect(minion.on_move_selected)
	
	# Setup enery bar
	energy_bar.max_value = minion.minion_data.energy
	energy_bar.value = energy_bar.max_value
	
	
	# Load all the moves into their slots and 
	# Add what move the particular button is associated to
	for idx in minion.available_skills.size():
		var move_button: TextureButton = get("move" + str(idx + 1))
		var move_scene = minion.available_skills[idx]
		var move: Move = move_scene.instantiate()
		move_button.set_meta("move", move_scene)
		move_button.texture_normal = move.move_data.texture
		move.queue_free()

# The below region is just making the buttons fire off the move selected signals
#region Connecting Signals
	if move1.has_meta("move"):

		move1.pressed.connect(func():
			move_selected.emit(move1.get_meta("move"))
			)
	
	if move2.has_meta("move"):

		move2.pressed.connect(func():
			move_selected.emit(move2.get_meta("move"))
			)
	
	if move3.has_meta("move"):

		move3.pressed.connect(func():
			move_selected.emit(move3.get_meta("move"))
			)
	
	if move4.has_meta("move"):

		move4.pressed.connect(func():
			move_selected.emit(move4.get_meta("move"))
			)
	
	if move5.has_meta("move"):
		move5.pressed.connect(func():
			move_selected.emit(move5.get_meta("move"))
			)
	
	if move6.has_meta("move"):
		move6.pressed.connect(func():
			move_selected.emit(move6.get_meta("move"))
			)
#endregion
