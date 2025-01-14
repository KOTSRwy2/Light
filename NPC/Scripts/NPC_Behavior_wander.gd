@tool
extends NPC_Behavior

const DIRECTION = [ Vector2.UP, Vector2.RIGHT ,Vector2.DOWN , Vector2.LEFT ]

@export var wander_range : int = 2 : set = _set_wander_range
@export var wander_speed : float = 30.0
@export var wander_duration : float = 1.0
@export var idle_duration : float = 1.0
@export var detactiable : bool = false

@onready var collision : CollisionShape2D = $CollisionShape2D



var original_potition : Vector2



func _ready() -> void:
	if Engine.is_editor_hint():
		return
	super()
	$CollisionShape2D.queue_free()
	original_potition = npc.global_position
	


func _process(delta : float) -> void:
	if Engine.is_editor_hint():
		return
	if abs( global_position.distance_to( original_potition ) ) > wander_range * 16:
		npc.velocity *= -1
		npc.dirction *= -1
		npc.update_dirction( global_position + npc.dirction )
		npc.update_animation()
		


func start() -> void:
	# IDLE PHASE
	if npc.do_behavior == false:
		return
	npc.state = "idle"
	npc.velocity = Vector2.ZERO
	npc.update_animation()
	await get_tree().create_timer( randf() * idle_duration + idle_duration * 0.5 ).timeout
	if npc.do_behavior == false:
		return
	# WALK STATE
	npc.state = "walk"
	var _dir : Vector2 = DIRECTION[ randi_range(0,3) ]
	npc.dirction = _dir
	npc.velocity = wander_speed * _dir
	npc.update_dirction( global_position + _dir )
	npc.update_animation()
	await get_tree().create_timer( randf() * wander_duration + wander_duration * 0.5 ).timeout
	# REPEAT
	if npc.do_behavior == false:
		return
	start()
	pass


func _set_wander_range( v : int ) -> void:
	wander_range = v
	$CollisionShape2D.shape.radius = v * 16
