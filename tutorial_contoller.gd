extends Node3D
class_name TerrainController


var ModelsBlocks: Array = []
var Models_belt: Array[MeshInstance3D] = []
@export var coin_count: int = 0
@export var Models_velocity: float = (15.0 * (coin_count * 0.10 + 1))
@export var num_Models_blocks = 4
@export_dir var Models_blocks_path = "res://Models"

var terrain_sequence: Array = [
	"terrain_7.tscn",
	"terrain_7.tscn",
	"terrain_7.tscn",
	"terrain_7.tscn",
	"terrain_7.tscn",
	"terrain_7.tscn",
	"terrain_7.tscn",
	"terrain_1.tscn",
	"terrain_7.tscn",
	"terrain_2.tscn",
	"terrain_7.tscn",
	"terrain_7.tscn",
	"terrain_7.tscn",
]
var current_terrain_index: int = 0 

func _ready() -> void:
	_load_Models_scenes(Models_blocks_path)
	_init_blocks(num_Models_blocks)

func _physics_process(delta: float) -> void:
	_progress_Models(delta)

func _init_blocks(number_of_blocks: int) -> void:
	for block_index in number_of_blocks:
		var block = _get_next_terrain_block().instantiate()
		if block_index == 0:
			block.position.z = block.mesh.size.y / 2
		else:
			_append_to_far_edge(Models_belt[block_index - 1], block)
		add_child(block)
		Models_belt.append(block)

func _progress_Models(delta: float) -> void:
	for block in Models_belt:
		block.position.z += Models_velocity * delta

	if Models_belt[0].position.z >= Models_belt[0].mesh.size.y / 2:
		var last_Models = Models_belt[-1]
		var first_Models = Models_belt.pop_front()

		var block = _get_next_terrain_block()
		if block == null:
			_transition_to_level_2()
			return

		var instance = block.instantiate()
		_append_to_far_edge(last_Models, instance)
		add_child(instance)
		Models_belt.append(instance)
		first_Models.queue_free()

func _append_to_far_edge(target_block: MeshInstance3D, appending_block: MeshInstance3D) -> void:
	appending_block.position.z = target_block.position.z - target_block.mesh.size.y / 2 - appending_block.mesh.size.y / 2

func _load_Models_scenes(target_path: String) -> void:
	var dir = DirAccess.open(target_path)
	for scene_path in dir.get_files():
		print("Loading terrain block scene: " + target_path + "/" + scene_path)
		ModelsBlocks.append(load(target_path + "/" + scene_path))

func _get_next_terrain_block() -> PackedScene:
	if current_terrain_index >= terrain_sequence.size():
		return null  
	var scene_name = terrain_sequence[current_terrain_index]
	current_terrain_index += 1
	return load(Models_blocks_path + "/" + scene_name)

func _transition_to_level_2() -> void:
	print("Level 1 complete. Transitioning to Level 2...")
	get_tree().change_scene_to_file("res://Level2.tscn") 
