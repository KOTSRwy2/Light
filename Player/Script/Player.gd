class_name Player extends CharacterBody2D

const DIR_4 = [Vector2.RIGHT,Vector2.DOWN,Vector2.LEFT,Vector2.UP]

signal DirectionChangeg( new_direction : Vector2 )


@onready var animation_player : AnimationPlayer = $AnimationPlayer
@onready var audio_stream_player : AudioStreamPlayer = $AudioStreamPlayer
@onready var state_machine : PlayerStateMachine = $State_Machiine



var cardinal_direction: Vector2 = Vector2.DOWN
var direction : Vector2 =Vector2.ZERO

func  _ready():
	state_machine.Initialize( self )
	pass
	


func _process(delta):
	direction = Vector2(
		Input.get_axis("LEFT","RIGHT"),
		Input.get_axis("UP","DOWN")
	).normalized()
	
	
	



func  _physics_process(delta):
	move_and_slide()



func UpdateAnimation( state : String ) -> void:
	animation_player.play( state + "_" + AnimDirection() )
	pass



func AnimDirection() -> String:
	if cardinal_direction == Vector2.DOWN:
		return "down"
	elif cardinal_direction == Vector2.UP:
		return "up"	
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	else:
		return "right"



func  SetDirection() -> bool:	
	if direction == Vector2.ZERO:
		return false
	var direction_id : int = int( round( ( direction + cardinal_direction*0.1 ).angle()/TAU * DIR_4.size() ) )	
	var new_direction = DIR_4[ direction_id ]	
	
	if new_direction==cardinal_direction:
		return false
		
	cardinal_direction=new_direction
	DirectionChangeg.emit( new_direction )
	return true 
