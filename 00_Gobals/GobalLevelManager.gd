extends Node

signal level_load_started
signal level_loaded
signal TileMapBoundChange( bounds : Array[ Vector2 ] )

var current_tilemap_bounds : Array[ Vector2 ]
var target_transition : String
var position_offset : Vector2


func _ready() -> void:
	await  get_tree().process_frame
	level_loaded.emit()

func ChangeTilemapBounds( bounds : Array[ Vector2 ]) -> void:
	current_tilemap_bounds = bounds
	TileMapBoundChange.emit( bounds )


func load_new_level(
	level_path : String,
	_targrt_transition : String,
	_postion_offset : Vector2
) -> void:
	
	get_tree().paused = true
	target_transition = _targrt_transition
	position_offset = _postion_offset
	
	#await SceneTransition.fade_out()
	
	level_load_started.emit()
	
	await get_tree().process_frame 
	
	get_tree().change_scene_to_file( level_path )
	
	#await SceneTransition.fade_in()
	
	get_tree().paused = false
	
	await get_tree().process_frame
	
	level_loaded.emit() 
	
	pass
