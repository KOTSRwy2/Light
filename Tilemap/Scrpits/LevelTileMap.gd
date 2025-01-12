class_name LevelTilemap extends TileMapLayer


# Called when the node enters the scene tree for the first time.
func _ready():
	GobalLevelManager.ChangeTilemapBounds( GetTilemapbounds() )
	pass # Replace with function body.


func GetTilemapbounds() -> Array[ Vector2 ]:
	var bounds : Array[ Vector2 ] = []
	bounds.append(
		Vector2( get_used_rect().position * rendering_quadrant_size )
	)
	bounds.append(
		Vector2( get_used_rect().end * rendering_quadrant_size )
	)
	return bounds
